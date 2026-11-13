
import QtQuick
import qs
import qs.style
import qs.views.bar

Widget {
  id: root
  text: BatteryService.isAvailable ? BatteryService.percentage + '%' : ''
  icon: BatteryService.symbol

  colorAnimated: {
    if (!BatteryService.isAvailable) return Colors.red
    if (mouseArea.containsMouse)     return colorOnHover
    if (BatteryService.isCharging)   return Colors.brightGreen
    if (BatteryService.isCritical)   return blinker.state ? Colors.red : Qt.alpha(Colors.red, Config.module.battery.criticalBlinkAlpha)
    return colorStd
  }

  Timer {
    id: blinker
    property bool state: false
    running: BatteryService.isCritical
    repeat: true
    interval: Config.module.battery.criticalBlinkRate
    onTriggered: state = !state
    onRunningChanged: if (!running) state = false
  }
}
