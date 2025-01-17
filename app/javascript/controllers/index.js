import { application } from "./application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
//which means, you dont need to declair each stimuls files in here. 
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Make Stimulus available globally
window.Stimulus = application 

export { application }

