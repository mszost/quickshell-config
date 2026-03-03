pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import qs.style

Singleton {
  id: root
  readonly property string symbol: filterActive ? Icons.sunTemperature : Icons.sun
  readonly property int percentage: (brightness / _maxBrightness) * 100
  property int brightness: 0
  property int _maxBrightness: 0
  property bool filterActive: false

  function toggleFilter() {
    if (filterActive) Hyprland.dispatch('exec killall hyprsunset')
    else Hyprland.dispatch('exec hyprsunset -t 3700')
    filterActive = !filterActive
  }

  function setBrightness(n: int) {
    Hyprland.dispatch(`exec brightnessctl set ${n}%`)
  }

  // Run once at shell startup
  Process {
    id: getMaxBrightness
    running: true
    command: ['sh', '-c', 
    `
      BL_PATH="/sys/class/backlight/$(ls /sys/class/backlight/ | head -n 1)"
      echo $(cat "$BL_PATH/max_brightness")
    `]
    stdout: SplitParser { onRead: data => { root._maxBrightness = data; } }
  }

  // Run continuously, watching for changes
  Process {
    id: getCurrentBrightness
    running: true
    command: ["sh", "-c", 
    `
      BL_PATH="/sys/class/backlight/$(ls /sys/class/backlight/ | head -n 1)"

      MAX_BRIGHTNESS=$(cat "$BL_PATH/max_brightness")
      CURRENT_BRIGHTNESS=$(cat "$BL_PATH/brightness")

      inotifywait --monitor "$BL_PATH/brightness" 2>/dev/null | while read -r _; do
        echo $(cat $BL_PATH/brightness) 
      done
    `]
    stdout: SplitParser { onRead: data => { root.brightness = data; } }
  }
}

