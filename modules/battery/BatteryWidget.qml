import QtQuick
import qs.style
import qs.components.bar

BarWidget {
  id: root
  text: BatteryService.isAvailable ? BatteryService.percentage + '%' : ''
  icon: BatteryService.symbol
  iconSize: 20
  animDuration: BatteryService.isCritical ? 300 : 100

  animatedColor: {
    if (!BatteryService.isAvailable) return Colors.red
    if (BatteryService.isCharging)   return '#4eed8e'
    if (BatteryService.isCritical)   return blinker.state ? Colors.red : Colors.alpha(Colors.red, 0.35)
    return mouseArea.containsMouse ? hoverColor : normalColor
  }

  Timer {
    id: blinker
    property bool state: false
    running: BatteryService.isCritical
    repeat: true
    interval: 350
    onTriggered: state = !state
    onRunningChanged: if (!running) state = false
  }
}

