import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { hospitalId: Number }
  static targets = ["position", "minutes"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "HospitalChannel", id: this.hospitalIdValue },
      { received: (position) => {
        console.log(position);
        if (position > parseInt(this.positionTarget.innerHTML)) return

        const previousPosition = this.positionTarget.innerHTML
        this.positionTarget.innerHTML = parseInt(previousPosition) - 1

        const timeString = this.#createTimeString(position)
        this.minutesTarget.innerHTML = timeString
      } }
    )
    console.log(`Subscribed to the chatroom with the id ${this.hospitalIdValue}.`)
  }

  #createTimeString(position) {
    const minutes = position * 20

    if (minutes >= 60) {
      const hours = Math.floor(minutes / 60)
      const minutesLeft = minutes % 60
      if (hours == 1) {
        return `${hours} hora e ${minutesLeft} minutos`
      } else {
        return `${hours} horas e ${minutesLeft} minutos`
      }
    } else {
      return `${minutes} minutos`
    }
  }
}
