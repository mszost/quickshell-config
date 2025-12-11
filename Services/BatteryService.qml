pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower


QtObject {
  id: root

  readonly property UPowerDevice device: UPower.displayDevice
  readonly property bool isAvailable: (device !== null)
  readonly property bool isCharging: isAvailable && (device.state === 1)
  
  readonly property int percentage: isAvailable ? Math.floor(device.percentage * 100) : 0
  readonly property bool isCritical: isAvailable && !isCharging && percentage <= 10
  
  //readonly property int timeRemaining: {
  //  device.state === UPowerDeviceState.Discharging ? device.timeToEmpty : device.timeToFull
  //}
  property string state: device.state //UPowerDeviceState.toString(device.state)
}
