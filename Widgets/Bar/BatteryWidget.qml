import QtQuick
import Quickshell

import qs.Services
import qs.Theme
import qs.Theme.Icons
import qs.Components


BarWidgetRow {
  id:root
  text: BatteryService.percentage + '%'
  icon: '\uEA30' 
  // animatedColor: uiState.color
  animationSpeed: BatteryService.isCritical ? 400 : defaultDuration 

  // readonly property var uiState: {
  //   if (!BatteryService.isAvailable) return { icon: errorIcon,    color: Colors.Orange }
  //   if (BatteryService.isCharging) return {   icon: chargingIcon, color: '#4eed8e' }
  //   if (BatteryService.isCritical) return {   icon: criticalIcon, color: blinker.state ? Colors.red : Colors.applyAlpha(Colors.red, .35) }
  //   if (BatteryService.state == 5) return {   icon: plugIcon,     color: containsMouse ? Colors.color8: Colors.foreground }  // Using AC power
  //   else return { icon: lowIcon, color: (containsMouse ? Colors.color8: Colors.foreground) }
  // }


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

