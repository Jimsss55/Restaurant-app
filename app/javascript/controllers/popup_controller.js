import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ["rootPopup", "popupContent"]
    connect(){
        this.initClickOutsideEventListener()
    }

    initClickOutsideEventListener(){
        this.rootPopupTarget.addEventListener("click", (event) => {
            if( !this.popupContentTarget.contains(event.target)) {
                this.closePopup()
            }
        })
    }

    openPopup(){
        this.rootPopupTarget.classList.add("active")
    }

    closePopup(){
        this.rootPopupTarget.classList.remove("active")
    }
}