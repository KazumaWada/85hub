import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("ExampleController connected!");
  }

  sayHello() {
    alert("Hello from Stimulus!");
  }
}