import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo"
export default class extends Controller {
  static targets = ["form"]

  connect() {
  }

  displayPhoto(event) {
    console.log(event.currentTarget)
    this.formTarget.submit()
  }
}
