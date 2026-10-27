pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs

Singleton {
  id: root

  readonly property QtObject cfg: Config.widget.cpuTemp

  readonly property real celsius: rawMilliCelsius / 1000
  readonly property int celsiusAsInt: Math.round(celsius)
  readonly property bool isCritical: celsius >= cfg.criticalThreshold

  property real rawMilliCelsius: 0

  FileView {
    id: sensor
    path: root.cfg.sensorPath
    onLoaded: {
      const value = parseInt(text())
      if (!isNaN(value)) root.rawMilliCelsius = value
    }
  }

  // sysfs files don't emit change notifications, so they have to be polled.
  Timer {
    interval: root.cfg.pollInterval
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: sensor.reload()
  }
}
