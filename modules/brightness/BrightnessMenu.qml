import QtQuick
import Quickshell
import Quickshell.Widgets
import qs
import qs.style
import qs.components.menu
import qs.components.bar

MenuWindow { 
  id: root
  module: 'brightness'  
  width: 360 * Config.globalUiScale

  MenuTitle {
    text: 'Display'
    icon: BrightnessService.symbol
  }

  MenuSlider {
    blockLabel: 'Global Brightness'
    valueText: `${Math.trunc(BrightnessService.brightness * 100)}%`
    value: BrightnessService.brightness
    onMoved: (sliderValue) => BrightnessService.setBrightness(sliderValue)
    onWheel: (wheel) => {
      const step = Config.module.brightness.scrollStep
      if (wheel.angleDelta.y > 0) BrightnessService.adjust(step)
      if (wheel.angleDelta.y < 0) BrightnessService.adjust(-step)
    }
  }
}
