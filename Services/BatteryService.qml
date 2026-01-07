pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower


Singleton {
  id: root

  readonly property UPowerDevice device: UPower.displayDevice
  readonly property int state: device.state //UPowerDeviceState.toString(device.state)
  readonly property bool isAvailable: (device !== null)
  readonly property bool isCharging: isAvailable && (device.state === 1)
  readonly property bool isCritical: isAvailable && !isCharging && percentage <= 10
  readonly property bool isPlugged: device.state === 4 || device.state === 5
  
  readonly property int percentage: isAvailable ? Math.floor(device.percentage * 100) : 0

  readonly property string symbol: {
    if (!isAvailable) return '\uED1C'
    if (isCharging)   return '\uEA33'
    if (isCritical)   return '\uFF1D'
    if (isPlugged)    return '\uEF3B'
    
    if (percentage >= 75) return '\uEA32'
    if (percentage >= 60) return '\uEA31'
    if (percentage >= 35) return '\uEA30'
    if (percentage >= 20) return '\uEA2F'
    return '\uEA34'
  }
  
  //readonly property int timeRemaining: {
  //  device.state === UPowerDeviceState.Discharging ? device.timeToEmpty : device.timeToFull
  //}
}

