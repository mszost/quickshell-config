import QtQuick
import qs
import qs.components.menu

MenuWindow {
  id: root

  MenuTitle {
    text: 'Display'
    icon: BrightnessService.symbol
  }

  MenuSlider {
    label: 'eDP-2'
    valueText: `${BrightnessService.percent}%`
    value: BrightnessService.brightness
    scrollStep: Config.module.brightness.scrollStep
    onMoved: (sliderValue) => BrightnessService.setBrightness(sliderValue)
  }
}
