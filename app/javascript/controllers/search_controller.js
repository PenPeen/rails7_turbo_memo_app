import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  connect() {}

  // 検索ボックスの内容を自動送信
  submit() {
    clearTimeout(this.searchTimeout);

    this.searchTimeout = setTimeout(() => {
      this.element.requestSubmit();
    }, 100);
  }

  /**
   * 検索ボックスをクリア
   */
  clear() {
    const word = document.getElementById("text2");
    word.value = "";
    this.element.requestSubmit();
  }
}
