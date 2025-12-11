import QtQuick
import Quickshell

import qs.Services
import qs.Theme
import qs.Theme.Icons
import qs.Components


BarWidgetSvg {
  id:root
  text: BatteryService.percentage + '%'
  icon: iconLoader.item
  animatedColor: uiState.color
  animationSpeed: BatteryService.isCritical ? 400 : defaultDuration 

  readonly property var uiState: {
    if (!BatteryService.isAvailable) return { icon: errorIcon,    color: Colors.Orange }
    if (BatteryService.isCharging) return {   icon: chargingIcon, color: '#4eed8e' }
    if (BatteryService.isCritical) return {   icon: criticalIcon, color: blinker.state ? Colors.red : Colors.applyAlpha(Colors.red, .35) }
    if (BatteryService.state == 5) return {   icon: plugIcon,     color: containsMouse ? Colors.color8: Colors.foreground }  // Using AC power
    else return { icon: lowIcon, color: (containsMouse ? Colors.color8: Colors.foreground) }
  }


  Component { id: lowIcon;      SvgBatteryLow {} }
  // Component { id: highIcon;     SvgBatteryHigh {} }
  Component { id: chargingIcon; SvgBatteryCharging {} }
  Component { id: criticalIcon; SvgBatteryEmpty {} }
  Component { id: plugIcon;     SvgBatteryPlug {} }
  Component { id: errorIcon;    SvgBatteryError {} }

  Binding { target: iconLoader.item; property: "width"; value: 20 }
  Binding { target: iconLoader.item; property: "height"; value: 20 }
  Binding { target: iconLoader.item; property: "color"; value: Qt.rgba(root.animatedColor.r, root.animatedColor.g, root.animatedColor.b, 1.0) }
  Binding { target: iconLoader.item; property: "opacity"; value: root.animatedColor.a }
  // Binding { target: iconLoader.item; property: "layer.enabled"; value: true }
  // Binding { target: iconLoader.item; property: "layer.smooth"; value: true }
 
  Loader {
    id: iconLoader
    sourceComponent: uiState.icon
  }  

  Timer {
    id: blinker
    property bool state: false
    running: true //BatteryService.isCritical
    repeat: true
    interval: 400
    onTriggered: state = !state
    onRunningChanged: if (!running) state = false  // Reset blinker state to 'visible' when timer stops 
  }
}

