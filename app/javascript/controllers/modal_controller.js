import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "background", "content", "caption"]
  static values = { open: Boolean }

  connect() {
    // Initialize with closed state
    this.openValue = false

    // Listen for escape key
    this.escapeHandler = this.handleEscape.bind(this)
    document.addEventListener("keydown", this.escapeHandler)
  }

  disconnect() {
    // Clean up event listener
    document.removeEventListener("keydown", this.escapeHandler)
  }

  open(event) {
    if (event) {
      event.preventDefault()

      // Get the URL and key from the clicked element
      const url = event.currentTarget.dataset.modalUrl
      const key = event.currentTarget.dataset.modalKey

      if (url && this.hasContentTarget) {
        // Load the content via Turbo
        this.contentTarget.src = url

        // Dispatch an event to notify the carousel which image to show
        const modalOpenedEvent = new CustomEvent("modal:opened", {
          bubbles: true,
          detail: { key: key }
        })

        document.dispatchEvent(modalOpenedEvent)
      }
    }

    // Open the modal
    this.openValue = true
  }

  close() {
    this.openValue = false
  }

  closeBackground(event) {
    // Only close if the background itself was clicked (not its children)
    if (event.target === this.backgroundTarget) {
      this.close()
    }
  }

  handleEscape(event) {
    if (event.key === "Escape" && this.openValue) {
      this.close()
    }
  }

  openValueChanged() {
    if (this.openValue) {
      // Show the modal
      this.containerTarget.classList.remove("hidden")
      // Use setTimeout to ensure the transition happens after display change
      setTimeout(() => {
        this.backgroundTarget.classList.remove("opacity-0")
        this.backgroundTarget.classList.add("opacity-100")
      }, 10)
    } else {
      // Hide the modal with transition
      this.backgroundTarget.classList.remove("opacity-100")
      this.backgroundTarget.classList.add("opacity-0")
      // Wait for transition to complete before hiding completely
      setTimeout(() => {
        this.containerTarget.classList.add("hidden")
      }, 300)
    }
  }

  updateCaption(event) {
    if (this.hasCaptionTarget && event.detail && event.detail.slideName) {
      this.captionTarget.textContent = event.detail.slideName
    }
  }
}
