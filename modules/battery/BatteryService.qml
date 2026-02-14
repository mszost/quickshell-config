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
   if (!isAvailable)     return Icons.tabler['battery-off']
   if (isCharging)       return Icons.tabler['battery-charging']
   if (isPlugged)        return Icons.tabler['battery-charging-2']
   if (isCritical)       return Icons.tabler['battery-exclamation']
   if (percentage >= 80) return Icons.tabler['battery-4']
   if (percentage >= 60) return Icons.tabler['battery-3']
   if (percentage >= 40) return Icons.tabler['battery-2']
   if (percentage >= 30) return Icons.tabler['battery-1']
   if (percentage >= 15) return Icons.tabler['battery']
   return Icons.tabler['battery-exclamation']
   // return Icons.tabler['alert-triangle']
  }
}

