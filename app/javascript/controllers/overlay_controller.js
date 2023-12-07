import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="overlay"
export default class extends Controller {
  static targets = ["spotDetails", "spotDetailsContent"]

  showSpotDetails(event) {
    console.log("click")
    const { id } = event.currentTarget.dataset
    fetch(`/spots/${id}`, {
      headers: {
        accepts: "text/html"
      }
    }).then(response => response.text())
      .then(this.#setSpotDetails)
  }

  #setSpotDetails = (html) => {
    this.spotDetailsTarget.innerHTML = html
    setTimeout(() => {
      this.spotDetailsContentTarget.classList.add('show')
    }, 100)
  }
}
