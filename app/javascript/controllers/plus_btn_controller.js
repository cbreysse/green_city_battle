import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="plus-btn"
export default class extends Controller {
  static targets = [ "popup" ]

  connect() {
  }

  handleClick(event) {
    this.popupTarget.classList.toggle("hidden")
  }
}
