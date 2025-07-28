import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"]
  static values = { url: String }

  connect() {
    console.log("DownloadCsvController connected!");
  }

  download(event) {
    console.log("Download button clicked!");
    event.preventDefault()
    const depId = this.selectTarget.value
    let url = this.urlValue
    if (depId) {
      url += `?department_id=${encodeURIComponent(depId)}`
    }
    window.location = url
  }
}
