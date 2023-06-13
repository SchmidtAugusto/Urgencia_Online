import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { hospitalId: Number }
  static targets = ["position", "minutes"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "HospitalChannel", id: this.hospitalIdValue },
      { received: (props) => {
        if (this.positionTarget.innerHTML != "coco de louro") {
          if (props.position > parseInt(this.positionTarget.innerHTML)) return

          const previousPosition = this.positionTarget.innerHTML
          const currentPosition = parseInt(previousPosition) - 1
          this.#printPosition(currentPosition)
        } else {
          this.minutesTarget.innerHTML = this.#createTimeString(props.totalWaitingTime / 20)
        }
      }
    }
    )
    console.log(`Subscribed to the chatroom with the id ${this.hospitalIdValue}.`)
  }

  #printPosition(position) {
    const timeString = this.#createTimeString(position)
    this.positionTarget.innerHTML = position
    this.minutesTarget.innerHTML = timeString
    console.log(position);
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
