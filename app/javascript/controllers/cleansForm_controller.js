import { Controller } from 'stimulus'
  export default class extends Controller {
    static targets = ["locationSelector", "plotSelector"]
    changeOnLocation(e) {
      const locationSelectElement = document.getElementById('clean_location_id')
      let indexOnSelectElement = parseInt(locationSelectElement.options.selectedIndex)
      let plotSelectorListTop
      this.plotSelectorTarget.childNodes.forEach(function(optGroup, x, plotSelectorTarget) {
        if (x == indexOnSelectElement-1) {
          optGroup.hidden = false
          plotSelectorListTop = optGroup.children[0].value
        }else{
          optGroup.hidden = true
        }
      });
      this.plotSelectorTarget.value = plotSelectorListTop
    }
  }
