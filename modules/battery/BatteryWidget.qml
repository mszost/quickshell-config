
import QtQuick
import qs
import qs.style
import qs.components.bar

Widget {
  id: root
  font: Config.widget.battery.textFont || Config.widget.textFont
  text: BatteryService.isAvailable ? BatteryService.percentage + '%' : ''
  icon: BatteryService.symbol
  animDuration: BatteryService.isCritical ? 200 : 100

  colorAnimated: {
    if (!BatteryService.isAvailable) return Colors.red
    if (mouseArea.containsMouse)     return colorOnHover
    if (BatteryService.isCharging)   return Colors.brightGreen
    if (BatteryService.isCritical)   return blinker.state ? Colors.red : Qt.alpha(Colors.red, 0.35) // 'white'
    return colorStd
  }


  Timer {
    id: blinker
    property bool state: false
    running: BatteryService.isCritical
    repeat: true
    interval: Config.widget.battery.criticalBlinkRate
    onTriggered: state = !state
    onRunningChanged: if (!running) state = false
  }
}
