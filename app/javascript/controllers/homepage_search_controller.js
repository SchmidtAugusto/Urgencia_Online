import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["searchbar", "cardWrapper", "form", "banner"];
  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  searchHospitals(event) {
    event.preventDefault();
    console.log(this.searchbarTarget.value);
    if (this.searchbarTarget.value != ""){
      this.bannerTarget.classList.add("collapse");
    } else {
      this.bannerTarget.classList.remove("collapse");
    }

    const url = `${this.formTarget.action}?query=${this.searchbarTarget.value}`

    fetch(url, {headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      this.cardWrapperTarget.outerHTML = data
    })
    .catch(error => {
      console.error(error);
    });
  }
}
