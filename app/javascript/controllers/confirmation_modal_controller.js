import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="confirmation-modal"
export default class extends Controller {
  static targets = [ "button", "closeButton", "modal" ]
  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  createPopUp(event) {
    console.log("click");
    this.modalTarget.classList.add("show");
  }

  closePopUp(event) {
    console.log("click");
    this.modalTarget.classList.remove("show");
  }
}
