pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower


Singleton {
  id: root

  readonly property UPowerDevice device: UPower.displayDevice
  property int state: device.state //UPowerDeviceState.toString(device.state)
  readonly property bool isAvailable: (device !== null)
  readonly property bool isCharging: isAvailable && (device.state === 1)
  readonly property bool isCritical: isAvailable && !isCharging && percentage <= 10
  readonly property bool isPlugged: device.state === 4 || device.state === 5
  
  readonly property int percentage: isAvailable ? Math.floor(device.percentage * 100) : 0
  
  //readonly property int timeRemaining: {
  //  device.state === UPowerDeviceState.Discharging ? device.timeToEmpty : device.timeToFull
  //}
}

