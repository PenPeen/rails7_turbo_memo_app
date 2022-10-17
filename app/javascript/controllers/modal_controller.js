import { Controller } from "@hotwired/stimulus";
import MicroModal from "micromodal";

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    MicroModal.show("modal-confirm");
  }

  close() {
    MicroModal.close("modal-confirm");
  }
}
