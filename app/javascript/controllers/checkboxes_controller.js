import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "checkbox" ]

  connect() {
    this.checkboxTargets.forEach(target => {
      if (target.dataset.checked == "true") {
        target.checked = true
      }
      if (target.dataset.checked == "false") {
        target.checked = false
      }
    })
  }
}
