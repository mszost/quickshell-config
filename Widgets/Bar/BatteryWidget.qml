import QtQuick
import Quickshell

import qs.Services
import qs.Theme
import qs.Theme.Icons
import qs.Components


BarWidgetRow {
  id: root
  text: BatteryService.isAvailable ? BatteryService.percentage + '%' : ""
  // icon: uiState.icon 
  // animatedColor: uiState.color
  animationSpeed: BatteryService.isCritical ? 300 : defaultDuration 

  // readonly property var uiState: {
  //   if (!BatteryService.isAvailable) return { icon: '\uED1C', color: Colors.red }
  //   if (BatteryService.isCharging)   return { icon: '\uEA33', color: '#4eed8e' }
  //   if (BatteryService.isCritical)   return { icon: '\uFF1D', color: blinker.state ? Colors.red : Colors.applyAlpha(Colors.red, .35) }
  //   if (BatteryService.state == 5)   return { icon: '\uEF3B', color: containsMouse ? Colors.color8: Colors.foreground }  // Using AC power
  //
  //   if (BatteryService.percentage >= 80) return { icon: '\uEA32', color: containsMouse ? Colors.color8: Colors.foreground }
  //   if (BatteryService.percentage >= 65) return { icon: '\uEA31', color: containsMouse ? Colors.color8: Colors.foreground }
  //   if (BatteryService.percentage >= 45) return { icon: '\uEA30', color: containsMouse ? Colors.color8: Colors.foreground }
  //   if (BatteryService.percentage >= 35) return { icon: '\uEA2F', color: containsMouse ? Colors.color8: Colors.foreground }
  //   if (BatteryService.percentage >= 15) return { icon: '\uEA34', color: containsMouse ? Colors.color8: Colors.foreground }
  // }

  animatedColor: {
      if (!BatteryService.isAvailable) return Colors.red
      if (BatteryService.isCharging)   return '#4eed8e'
      if (BatteryService.isCritical)   return blinker.visibleState ? Colors.red : Colors.applyAlpha(Colors.red, 0.35)
      return containsMouse ? Colors.color8 : Colors.foreground
  }

    icon: {
      if (!BatteryService.isAvailable) return '\uED1C'
      if (BatteryService.isCharging)   return '\uEA33'
      if (BatteryService.isCritical)   return '\uFF1D'
      if (BatteryService.state === 5)  return '\uEF3B' // AC Power

      const p = BatteryService.percentage
      if (p >= 80) return '\uEA32'
      if (p >= 65) return '\uEA31'
      if (p >= 45) return '\uEA30'
      if (p >= 35) return '\uEA2F'
      return '\uEA34' // Fallback/Low
    }

  Timer {
    id: blinker
    property bool state: false
    running: BatteryService.isCritical
    repeat: true
    interval: 350
    onTriggered: state = !state
    onRunningChanged: if (!running) state = false  // Reset blinker state to 'visible' when timer stops 
  }
}

