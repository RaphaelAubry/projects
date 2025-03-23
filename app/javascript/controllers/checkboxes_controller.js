import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "checkbox" ]

  connect() {
    for (let checkbox of this.checkboxTargets) {
      if (checkbox.dataset.checked == "true") {
        checkbox.checked = true
      }
      if (checkbox.dataset.checked == "false") {
        checkbox.checked = false
      }
    }
  }
}
