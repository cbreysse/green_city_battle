import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  static values = {
    spotId: Number,
    actionId: Number,
  }

  connect() {
    fetch(`/time_until_next_action?spot_id=${this.spotIdValue}&action_id=${this.actionIdValue}`, {
      headers: {
        accept: "application/json",
      }}).then(response => response.json())
      .then(this.#setCountdown)
  }

  #setCountdown = (data) => {
    if (data.next_possible_action_timestamp) {
      const targetTimestamp = new Date(data.next_possible_action_timestamp
        ).getTime()

      const countdownInterval = setInterval(() => {
        const currentTime = new Date().getTime()
        const distance = targetTimestamp - currentTime

        if (distance <= 0) {
          clearInterval(countdownInterval)
          return
        }

        const days = Math.floor(distance / (1000 * 60 * 60 * 24))
        const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))

        this.element.innerHTML = ` dans ${days}j ${hours}h`
      }, 1000)
    }
  }
}
