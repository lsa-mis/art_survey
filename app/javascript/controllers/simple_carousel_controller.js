import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "indicator", "prev", "next"]
  static values = { index: Number }

  connect() {
    // Initialize the carousel
    this.indexValue = this.indexValue || 0

    console.log("Simple carousel connected with", this.slideTargets.length, "slides")

    // Show loading indicators
    this.element.querySelectorAll('.loading-indicator').forEach(indicator => {
      indicator.style.display = 'flex'
    })

    // Wait for all images to load
    this.loaded = 0
    this.totalImages = this.element.querySelectorAll('img').length
    console.log("Total images to load:", this.totalImages)

    if (this.totalImages === 0) {
      this.showSlide(this.indexValue)
    } else {
      this.element.querySelectorAll('img').forEach(img => {
        if (img.complete) {
          this.imageLoaded(img)
        } else {
          img.addEventListener('load', () => this.imageLoaded(img))
          img.addEventListener('error', () => this.imageLoaded(img))
        }
      })
    }

    // Listen for modal open events
    document.addEventListener("modal:opened", this.handleModalOpened.bind(this))
    console.log("Added event listener for modal:opened")
  }

  disconnect() {
    document.removeEventListener("modal:opened", this.handleModalOpened.bind(this))
  }

  imageLoaded(img) {
    // Hide the loading indicator for this specific image
    if (img && img.previousElementSibling && img.previousElementSibling.classList.contains('loading-indicator')) {
      img.previousElementSibling.style.display = 'none'
    }

    this.loaded++
    console.log(`Image loaded: ${this.loaded}/${this.totalImages}`)
    if (this.loaded >= this.totalImages) {
      this.showSlide(this.indexValue)
    }
  }

  next() {
    this.indexValue = (this.indexValue + 1) % this.slideTargets.length
  }

  previous() {
    this.indexValue = (this.indexValue - 1 + this.slideTargets.length) % this.slideTargets.length
  }

  showSlideByIndex(event) {
    const index = parseInt(event.currentTarget.dataset.index || 0)
    this.indexValue = index
  }

  indexValueChanged() {
    this.showSlide(this.indexValue)
  }

  showSlide(index) {
    console.log("Showing slide", index)
    // Hide all slides first
    this.slideTargets.forEach((slide, i) => {
      slide.classList.toggle('hidden', i !== index)
    })

    // Update indicators if they exist
    if (this.hasIndicatorTargets) {
      this.indicatorTargets.forEach((indicator, i) => {
        indicator.classList.toggle('active', i === index)
      })
    }

    // Announce current slide for screen readers
    const currentSlide = this.slideTargets[index]
    const filename = currentSlide.dataset.filename || `Image ${index + 1}`
    console.log("Current slide filename:", filename)

    // Dispatch an event that can be used by other controllers
    this.dispatch("slide-change", {
      detail: {
        index: index,
        slideName: filename
      }
    })
  }

  // Method to be called when the modal is opened
  handleModalOpened(event) {
    console.log("Modal opened event received:", event.detail)
    if (event.detail && event.detail.key) {
      this.navigateToKey(event.detail.key)
    }
  }

  // Method to navigate to a slide by its key
  navigateToKey(key) {
    console.log("Navigating to key:", key)
    console.log("Available slides:", this.slideTargets.map(slide => slide.dataset.key))
    const slideIndex = this.slideTargets.findIndex(slide => slide.dataset.key === key)
    console.log("Found slide index:", slideIndex)
    if (slideIndex >= 0) {
      this.indexValue = slideIndex
    }
  }
}
