import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire

import qs.Theme
import qs.Components

// TODO: Dynamic icon
// TODO: Control volume with scrollwheel
// TODO: Sub-menu (input device switcher)

BarWidgetRow {
    id: root
    text: {
      if (!sink || !sink.audio) return 'N/A'
      if (sink.audio.muted) return 'Muted'
      return Math.round(sink.audio.volume * 100) + '%'
    }
    icon: '\uE1AB' 
    iconWeight: 600
    onClicked: Hyprland.dispatch("exec pavucontrol") 

    property var sink: Pipewire.defaultAudioSink

    // scroll event handler
    mouseArea.onWheel: (wheelEvent) => {
      const step = 0.02

      if (wheelEvent.angleDelta.y > 0) {
        sink.audio.volume = Math.min(sink.audio.volume + step, 1)
      } 
      if (wheelEvent.angleDelta.y < 0) {
        sink.audio.volume = Math.max(sink.audio.volume - step, 0)
      }
    }
}
