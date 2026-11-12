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
    label: Config.module.brightness.menuLabel || BrightnessService.deviceName
    valueText: `${BrightnessService.percent}%`
    value: BrightnessService.brightness
    scrollStep: Config.module.brightness.scrollStep
    onMoved: (sliderValue) => BrightnessService.setBrightness(sliderValue)
  }
}
