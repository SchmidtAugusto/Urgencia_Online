import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  static targets = ['map', 'routeDuration']

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap()
  }

  #addMarkersToMap() {
    const bounds = new mapboxgl.LngLatBounds()
    const coordinates = []

    this.markersValue.forEach((marker) => {
      coordinates.push([marker.lng, marker.lat])

      new mapboxgl.Marker({ color: 'red' })
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map)

      bounds.extend([marker.lng, marker.lat])
    })

    // Add a marker for the user's current location
    navigator.geolocation.getCurrentPosition((position) => {
      const latitude = position.coords.latitude
      const longitude = position.coords.longitude

      coordinates.push([longitude, latitude])

      const userMarker = new mapboxgl.Marker() // Specify a custom color for the user's marker
        .setLngLat([longitude, latitude])
        .addTo(this.map)

      bounds.extend([longitude, latitude])
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })

      this.#getRoute(coordinates)
    }, (error) => {
      console.log('Unable to retrieve your location')
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
    })
  }

  #printDuration(routeDuration) {
    const duration = Math.round(routeDuration / 60) // convert seconds to minutes, rounded up
    this.routeDurationTarget.innerHTML = `${duration} minutos`
  }

  #getRoute(coordinates) {
    // Make a request to Mapbox Directions API for the route
    const apiUrl = `https://api.mapbox.com/directions/v5/mapbox/driving/${coordinates.join(';')}?geometries=geojson&access_token=${mapboxgl.accessToken}`
    fetch(apiUrl)
      .then(response => response.json())
      .then(data => {
        const route = data.routes[0].geometry
        const routeDuration = data.routes[0].duration


        this.#printDuration(routeDuration)

        this.map.addSource('route', {
          type: 'geojson',
          data: {
            type: 'Feature',
            geometry: route
          }
        })

        this.map.addLayer({
          id: 'route',
          type: 'line',
          source: 'route',
          layout: {
            'line-join': 'round',
            'line-cap': 'round'
          },
          paint: {
            'line-color': '#0080ff',
            'line-width': 4
          }
        })
      })
      .catch(error => {
        console.log('Unable to retrieve route data', error)
      })
  }
}
