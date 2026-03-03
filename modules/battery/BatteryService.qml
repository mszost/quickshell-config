pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.style

Singleton {
  id: root

  readonly property UPowerDevice device: UPower.displayDevice
  readonly property int state: device.state
  readonly property bool isAvailable: (device !== null)
  readonly property bool isCharging: isAvailable && (device.state === 1)
  readonly property bool isCritical: isAvailable && !isCharging && percentage <= 10
  readonly property bool isPlugged: device.state === 4 || device.state === 5
  
  readonly property int percentage: isAvailable ? Math.floor(device.percentage * 100) : 0

 //  readonly property int timeRemaining: {
 //   device.state === device.Discharging ? device.timeToEmpty : device.timeToFull
 // }

 readonly property string symbol: {
   if (!isAvailable)     return Icons.batteryOff
   if (isCharging)       return Icons.batteryCharging
   if (isPlugged)        return Icons.batteryPlugged
   if (isCritical)       return Icons.batteryCritical
   if (percentage >= 80) return Icons.battery4
   if (percentage >= 60) return Icons.battery3
   if (percentage >= 40) return Icons.battery2
   if (percentage >= 30) return Icons.battery1
   if (percentage >= 15) return Icons.battery0
   return Icons.batteryCritical
  }
}

