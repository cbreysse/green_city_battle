import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo"
export default class extends Controller {
  connect() {
  }

  displayPhoto(event) {
    console.log(event.currentTarget)
  }
}
