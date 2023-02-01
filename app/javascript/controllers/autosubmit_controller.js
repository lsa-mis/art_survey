import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ['form', 'sidebar', 'min_value_cost', 'max_value_cost', 'value_cost_error']

  search() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      var min_value_cost = parseInt(this.min_value_costTarget.value)
      var max_value_cost = parseInt(this.max_value_costTarget.value)

      if (Number.isNaN(min_value_cost)) { min_value_cost = 0 }
      if (Number.isNaN(max_value_cost)) { max_value_cost = min_value_cost }

      if (min_value_cost != 0 || max_value_cost != 0) {

        if (min_value_cost < 0) {
          this.value_cost_errorTarget.classList.add("value_cost-error--display")
          this.value_cost_errorTarget.classList.remove("value_cost-error--hide")
          this.value_cost_errorTarget.innerText = "From should be positive"
        }
        else if (min_value_cost > max_value_cost) {
          this.value_cost_errorTarget.classList.add("value_cost-error--display")
          this.value_cost_errorTarget.classList.remove("value_cost-error--hide")
          this.value_cost_errorTarget.innerText = "From should be smaller than To"
        }
        else {
          this.value_cost_errorTarget.classList.add("value_cost-error--hide")
          this.value_cost_errorTarget.classList.remove("value_cost-error--display")
          this.value_cost_errorTarget.innerText = ""

          Turbo.navigator.submitForm(this.formTarget)
        }
      }
      else {
        Turbo.navigator.submitForm(this.formTarget)
      }
    }, 600)
  }

  clearFilters() {
    var url = window.location.pathname
    Turbo.visit(url)
  }

}
