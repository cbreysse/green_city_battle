import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spot-details"
export default class extends Controller {
  connect() {
  }

  closeOverlay() {
    this.element.classList.remove('show')
  }
}
