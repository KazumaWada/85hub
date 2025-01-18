import { Controller } from "@hotwired/stimulus"
import Quill from "quill"

export default class extends Controller {
  static targets = ["editor", "input"]

  connect() {
    console.log("hey from quill_controller!!");
    console.log("Quill loaded:", typeof Quill);  // Check if Quill is loaded
    console.log("Editor target:", this.editorTarget);  // Check if target exists

    try {
      this.quill = new Quill(this.editorTarget, {
        theme: 'snow',
        placeholder: "i dont think anything is hard, its just takes time.",
        modules: {
          toolbar: [
            [{ 'header': [1, 2, 3, false] }], 
            ['bold', 'italic', 'underline'],
            ['link','image', 'blockquote']
          ]
        },
        formats: {
            link: {
                //tailwind did dirty for link color tho :(
              class: 'text-blue-500 hover:text-blue-700 underline'
            }
          }
      })

      console.log("Quill initialized:", this.quill);  // Check if Quill initialized

      this.quill.on('text-change', () => {
        this.inputTarget.value = this.quill.root.innerHTML
      })
    } catch (error) {
      console.error("Error initializing Quill:", error);  // Catch any errors
    }
  }
}