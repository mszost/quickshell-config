pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs
import qs.style

// Controls hyprsunset. Temperature, gamma and on/off persist in `Store.hyprsunset`.
//
// hyprsunset runs detached, so it survives shell reloads and is found again on startup like an
// instance started elsewhere (autostart, hypridle, ...). Values set while stopped are used on the
// next start; values set while running are sent over IPC.
Singleton {
  id: root

  readonly property QtObject cfg: Config.module.hyprsunset
  readonly property QtObject store: Store.hyprsunset

  property bool running: false

  readonly property int temperature: store.temperature  // Kelvin
  readonly property int gamma: store.gamma              // Percent
  readonly property string symbol: Icons.moon

  // Normalized 0-1 values, for sliders.
  readonly property real temperatureNorm: (temperature - cfg.minTemperature) / (cfg.maxTemperature - cfg.minTemperature)
  readonly property real gammaNorm: (gamma - cfg.minGamma) / (cfg.maxGamma - cfg.minGamma)

  function start() {
    store.enabled = true
    if (running) return
    Quickshell.execDetached([
      'hyprsunset',
      '--temperature', String(temperature),
      '--gamma', String(gamma),
      '--gamma_max', String(cfg.maxGamma)
    ])
    running = true
  }

  function stop() {
    store.enabled = false
    if (!running) return
    Quickshell.execDetached(['pkill', '-x', 'hyprsunset'])  // Exiting restores the screen
    running = false
  }

  function setRunning(on) {
    if (on) start()
    else stop()
  }

  function setTemperature(kelvin) {
    store.temperature = Math.round(Math.max(cfg.minTemperature, Math.min(cfg.maxTemperature, kelvin)))
    applyTimer.restart()
  }

  function setGamma(percent) {
    store.gamma = Math.round(Math.max(cfg.minGamma, Math.min(cfg.maxGamma, percent)))
    applyTimer.restart()
  }

  function setTemperatureNorm(val) {
    setTemperature(cfg.minTemperature + val * (cfg.maxTemperature - cfg.minTemperature))
  }

  function setGammaNorm(val) {
    setGamma(cfg.minGamma + val * (cfg.maxGamma - cfg.minGamma))
  }

  // Sends the current values to a running instance.
  function apply() {
    if (!running) return
    Quickshell.execDetached(['hyprctl', 'hyprsunset', 'temperature', String(temperature)])
    Quickshell.execDetached(['hyprctl', 'hyprsunset', 'gamma', String(gamma)])
  }

  // Coalesces rapid slider movement into one IPC call.
  Timer {
    id: applyTimer
    interval: root.cfg.applyDelay
    onTriggered: root.apply()
  }

  // On startup: adopt a running instance's values, or restore the saved on/off state.
  Process {
    id: detect
    running: true
    command: ['pgrep', '-x', 'hyprsunset']
    onExited: (code) => {
      if (code === 0) {
        root.running = true
        readTemperature.running = true
        readGamma.running = true
      } else if (root.store.enabled) {
        root.start()
      }
    }
  }

  Process {
    id: readTemperature
    command: ['hyprctl', 'hyprsunset', 'temperature']
    stdout: StdioCollector {
      onStreamFinished: {
        const val = parseInt(text)
        if (!isNaN(val)) root.store.temperature = val
      }
    }
  }

  Process {
    id: readGamma
    command: ['hyprctl', 'hyprsunset', 'gamma']
    stdout: StdioCollector {
      onStreamFinished: {
        const val = parseInt(text)
        if (!isNaN(val)) root.store.gamma = val
      }
    }
  }
}
