import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ['form', 'sidebar', 'min_value_cost', 'max_value_cost', 'value_cost_error']

  search() {
    clearTimeout(this.timeout)

    const MIN = parseInt(0)
    const MAX = parseInt(100000)

    this.timeout = setTimeout(() => {
      var min_value_cost = parseInt(this.min_value_costTarget.value)
      var max_value_cost = parseInt(this.max_value_costTarget.value)

      if (Number.isNaN(min_value_cost)) { min_value_cost = 0 }
      if (Number.isNaN(max_value_cost)) { max_value_cost = 0 }

      if (min_value_cost != 0 || max_value_cost != MAX) {

        if (min_value_cost < 0) {
          this.value_cost_errorTarget.classList.add("value_cost-error--display")
          this.value_cost_errorTarget.classList.remove("value_cost-error--hide")
          this.value_cost_errorTarget.innerText = "Min should be positive"
        }
        else if (max_value_cost > MAX) {
          this.value_cost_errorTarget.classList.add("value_cost-error--display")
          this.value_cost_errorTarget.classList.remove("value_cost-error--hide")
          this.value_cost_errorTarget.innerText = "Max should be less then " + MAX
        }
        else if (min_value_cost > max_value_cost) {
          this.value_cost_errorTarget.classList.add("value_cost-error--display")
          this.value_cost_errorTarget.classList.remove("value_cost-error--hide")
          this.value_cost_errorTarget.innerText = "Min should be smaller than Max"
        }
        else {
          this.value_cost_errorTarget.classList.add("value_cost-error--hide")
          this.value_cost_errorTarget.classList.remove("value_cost-error--display")
          this.value_cost_errorTarget.innerText = ""

          Turbo.navigator.submitForm(this.formTarget)
          this.sidebarTarget.classList.toggle('-translate-x-full')
        }
      }
      else {
        Turbo.navigator.submitForm(this.formTarget)
        this.sidebarTarget.classList.toggle('-translate-x-full')
      }
    }, 600)
  }

  clearFilters() {
    var url = window.location.pathname
    Turbo.visit(url)
  }

}
