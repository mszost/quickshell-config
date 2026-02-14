import Quickshell.Hyprland

import qs.style
import qs.components.bar

BarWidget { 
  id: root
  // text: `${BacklightService.percentage}%`
  icon: BacklightService.symbol 

  // Scroll event handler
  mouseArea.onWheel: (wheelEvent) => {
    let step = 2
    if (wheelEvent.angleDelta.y > 0) BacklightService.setBrightness(BacklightService.percentage + step)
    if (wheelEvent.angleDelta.y < 0) BacklightService.setBrightness(BacklightService.percentage - step)
  }

  mouseArea.onClicked: menu.isVisible = true

  BacklightPanel {
    id: menu
    boundItem: root
    widgetContainerPos: root.widgetContainerPos
  }
}
