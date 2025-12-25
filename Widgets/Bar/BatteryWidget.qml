import QtQuick

import Quickshell

import qs.Services
import qs.Theme
import qs.Components


BarWidget {
  id: root
  text: BatteryService.isAvailable ? BatteryService.percentage + '%' : ""
  iconSize: 20
  animationSpeed: BatteryService.isCritical ? 300 : defaultDuration 

  animatedColor: {
      if (!BatteryService.isAvailable) return Colors.red
      if (BatteryService.isCharging)   return '#4eed8e'
      if (BatteryService.isCritical)   return blinker.state ? Colors.red : Colors.applyAlpha(Colors.red, 0.35)
      return containsMouse ? Colors.color8 : Colors.foreground
  }

  icon: {
    if (!BatteryService.isAvailable) return '\uED1C'
    if (BatteryService.isCharging)   return '\uEA33'
    if (BatteryService.isCritical)   return '\uFF1D'
    if (BatteryService.isPlugged)    return '\uEF3B' // AC Power
    
    const p = BatteryService.percentage
    if (p >= 75) return '\uEA32'
    if (p >= 60) return '\uEA31'
    if (p >= 35) return '\uEA30'
    if (p >= 20) return '\uEA2F'
    return '\uEA34'  // Fallback/Low
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

