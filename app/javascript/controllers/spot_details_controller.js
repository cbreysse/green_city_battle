import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spot-details"
export default class extends Controller {
  static values = {
    id: Number,
    name: String,
    address: String
  }

  static targets = ["title", "address"]

  connect() {
  }

  closeOverlay() {
    this.element.classList.remove('show')
  }

  nameValueChanged() {
    this.titleTarget.innerText = this.nameValue
  }

  addressValueChanged() {
    this.addressTarget.innerText = this.addressValue
  }

}
