import { Controller } from "@hotwired/stimulus"
import JSConfetti from 'js-confetti'

// Connects to data-controller="confetti"
export default class extends Controller {
  connect() {
    const jsConfetti = new JSConfetti()
    jsConfetti.addConfetti({
      emojis: ['👩🏽‍🌾', '👨🏽‍🌾', '👑', '🐝', '🪲', '🐞', '🦎', '🦚', '🌲', '🌳', '🌴', '🌱', '🌿', '☘️', '🍀', '🪴', '🍃', '💐', '🌼', '🌻', '🌹', '🥦', '🥕', '🥬'],
      emojiSize: 100,
      confettiNumber: 50,
    })
  }
}
