import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import qs
import qs.style
import qs.components.bar

BarWidget {
  id: root
  text: AudioService.isMuted ? 'Muted' : AudioService.volumeAsInt + '%'
  icon: AudioService.symbol
  spacing: 1
  normalColor: {
    if (AudioService.volumeAsInt > 100) return Colors.red
    if (menu.isVisible) return hoverColor
    return Colors.foreground
  }
  
  // Scroll event handler
  mouseArea.onWheel: (wheelEvent) => {
    let step = 0.02
    if (wheelEvent.angleDelta.y > 0) AudioService.setVolume(AudioService.volume + step)
    if (wheelEvent.angleDelta.y < 0) AudioService.setVolume(AudioService.volume - step)
  }

  mouseArea.onClicked: menu.isVisible = true

  AudioPanel {
    id: menu
    boundItem: root
    widgetContainerPos: root.widgetContainerPos
  }
}

