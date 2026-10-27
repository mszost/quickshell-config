pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs
import qs.style

Singleton {
  id: root

  readonly property QtObject cfg: Config.widget.brightness

  // `brightnessctl` invocation prefix, scoped to the configured class/device.
  readonly property list<string> baseCommand: {
    const args = ['brightnessctl', '--class=' + cfg.deviceClass]
    if (cfg.device !== '') args.push('--device=' + cfg.device)
    return args
  }

  property real brightness: 0  // normalized 0-1
  property bool available: false

  readonly property int percent: Math.round(brightness * 100)
  readonly property string symbol: Icons.sun

  function setBrightness(val) {
    if (!available) return
    const clamped = Math.max(cfg.minBrightness, Math.min(1, val))
    brightness = clamped  // optimistic update so the widget responds immediately
    Quickshell.execDetached(baseCommand.concat(['set', Math.round(clamped * 100) + '%']))
  }

  function adjust(delta) {
    setBrightness(brightness + delta)
  }

  // Parses `brightnessctl -m info`: "device,class,current,percent%,max"
  function parse(output) {
    const fields = output.trim().split(',')
    const current = Number(fields[2])
    const max = Number(fields[4])
    if (fields.length < 5 || !(max > 0)) {
      available = false
      return
    }
    brightness = current / max
    available = true
  }

  Process {
    id: reader
    command: root.baseCommand.concat(['--machine-readable', 'info'])
    stdout: StdioCollector {
      onStreamFinished: root.parse(text)
    }
  }

  // Keeps the value in sync with changes made outside the shell (keybinds, etc).
  Timer {
    interval: root.cfg.pollInterval
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      if (!reader.running) reader.running = true
    }
  }
}
