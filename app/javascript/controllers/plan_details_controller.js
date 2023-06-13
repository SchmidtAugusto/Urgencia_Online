import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="plan-details"
export default class extends Controller {
  connect() {
  }
  edit(event) {
    const inputs = document.getElementsByClassName("account-input");
    const saveButton = document.getElementById("save-button")
    const editButton = document.getElementById("edit-button")

    event.preventDefault()
    Array.from(inputs).forEach((input)=>{
      input.disabled = false
    })

    saveButton.classList.remove("d-none")
    editButton.classList.add("d-none")
  }
}
