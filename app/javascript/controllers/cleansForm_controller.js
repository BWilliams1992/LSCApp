import { Controller } from 'stimulus'
  export default class extends Controller {
    static targets = ["locationSelector", "plotSelector"]
    changeOnLocation(e) {
      const locationSelectElement = document.getElementById('clean_location_id')
      let indexOnSelectElement = parseInt(locationSelectElement.options.selectedIndex)
      
      let selectedLocation = locationSelectElement.options[indexOnSelectElement].text

      let selectedLocationOptionGroup = this.plotSelectorTarget.children[indexOnSelectElement-1].innerHTML
      this.plotSelectorTarget.childNodes.forEach(function(optGroup, x) {
        if (x == indexOnSelectElement-1) {
          optGroup.hidden = false
        }else{
          optGroup.hidden = true
        }
      });
    }
  }
