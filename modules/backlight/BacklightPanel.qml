import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import qs
import qs.style
import qs.components.panel

Scope {
  id: root
  
  required property var boundItem
  required property var widgetContainerPos
  
  readonly property real bgAlpha: Config.menuRowAlpha ?? Config.alpha ?? 1.0
  
  property alias isVisible: panel.isVisible
  onIsVisibleChanged: GlobalStates.menuAudioIsOpen = panel.isVisible
  
  Panel {
    id: panel
    boundItem: root.boundItem
    widgetContainerPos: root.widgetContainerPos

    PanelTitle {
      id: titleBlock
      text: 'Brightness'
      icon: BacklightService.symbol
      serviceBtn.onClicked: BacklightService.toggleFilter()
    }

    PanelSlider {
      text: 'Display eDP-2'
      valueText: `${BacklightService.percentage}%`
      value: BacklightService.percentage / 100
      onMoved: (sliderValue) => BacklightService.setBrightness(sliderValue * 100)
      onWheel: (wheel) => {
        if (wheel.angleDelta.y > 0) BacklightService.setBrightness(BacklightService.percentage + 5)
        if (wheel.angleDelta.y < 0) BacklightService.setBrightness(BacklightService.percentage - 5)
      }
    }
  }
}

