import QtQuick
import qs
import qs.style
import qs.components.bar

Widget {
  id: root
  visible: BrightnessService.available
  text: BrightnessService.percent + '%'
  icon: BrightnessService.symbol
  spacing: 1

  // Scroll event handler
  mouseArea.onWheel: (wheelEvent) => {
    const step = Config.module.brightness.scrollStep
    if (wheelEvent.angleDelta.y > 0) BrightnessService.adjust(step)
    if (wheelEvent.angleDelta.y < 0) BrightnessService.adjust(-step)
  }

  mouseArea.onClicked: menu.open = !menu.open

  BrightnessMenu {
    id: menu
    boundWidget: root
  }
}
