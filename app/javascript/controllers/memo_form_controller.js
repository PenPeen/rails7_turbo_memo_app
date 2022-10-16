import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="memo-form"
export default class extends Controller {
  connect() {
    const textArea = document.querySelector(".memo-field");
    const text = textArea.value;

    textArea.value = "";
    textArea.focus();
    textArea.value = text;
  }

  submit() {
    clearTimeout(this.timeout);

    this.timeout = setTimeout(() => {
      this.element.requestSubmit();
      console.log("submit");
    }, 200);
  }
}
