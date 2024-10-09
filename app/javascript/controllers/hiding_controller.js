import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "hideable", "button" ]

  toggle() {
    if (this.hidden()) {
      this.show();
    } else {
      this.hide();
    }
  }

  hidden() {
    return this.hideableTarget.hidden
  }

  hide() {
    this.hideableTarget.hidden = true
    this.buttonTarget.innerText = this.buttonTarget.innerText.replace("Hide","Show")
  }

  show() {
    this.hideableTarget.hidden = false
    this.buttonTarget.innerText = this.buttonTarget.innerText.replace("Show","Hide")
  }
}
