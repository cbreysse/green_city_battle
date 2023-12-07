import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-favorite"
export default class extends Controller {
  connect() {
  }

  toggle() {
    const url = this.element.dataset.url
    const method = this.element.dataset.method
    fetch(url, {
      method: method,
      headers: {
        Accept: "application/json"
      }
    })
      .then(res => res.json())
      .then(data => {
        this.element.outerHTML = data.heart_html
      })

  }
}
