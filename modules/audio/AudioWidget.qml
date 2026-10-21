import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import qs
import qs.style
import qs.components.bar

Widget {
  id: root
  spacing: 1
  font: Config.widget.audio.textFont || Config.widget.textFont
  text: AudioService.isMuted ? 'Muted' : AudioService.volumeAsInt + '%'
  icon: AudioService.symbol
  
  colorStd: {
    if (AudioService.volumeAsInt > 100) return Colors.red
    return Colors.mOnSurface
  }
  
  // Scroll event handler
  mouseArea.onWheel: (wheelEvent) => {
    let step = 0.02
    if (wheelEvent.angleDelta.y > 0) AudioService.setVolume(AudioService.volume + step)
    if (wheelEvent.angleDelta.y < 0) AudioService.setVolume(AudioService.volume - step)
  }
}
