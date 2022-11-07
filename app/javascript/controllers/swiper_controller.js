import Swiper from "swiper";
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "next", "prev"];
  static values = { activeKey: String };

  connect() {
    this.swiper = new Swiper(this.containerTarget, {
      navigation: {
        nextEl: this.nextTarget,
        prevEl: this.prevTarget,
      },
      on: {
        slideChange: this.handleSlideChange.bind(this),
      },
    });
  }

  navigate(event) {
    event.preventDefault();

    const { key } = event.detail;

    this.activeKeyValue = key;
  }

  activeKeyValueChanged() {
    const activeSlide = this.swiper?.slides.findIndex(
      (slide) => slide.dataset.key == this.activeKeyValue
    );

    this.swiper?.slideTo(activeSlide, 0);
  }

  handleSlideChange(swiper) {
    this.dispatch("slide-change", {
      detail: { slideName: swiper.slides[swiper.activeIndex].dataset.filename },
    });
  }

}