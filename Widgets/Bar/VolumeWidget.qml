import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.Theme
import qs.Components
import qs.Services

BarWidget {
  id: root

  text: AudioService.isMuted ? 'Muted' : volumeAsInt + '%'
  iconSize: 16
  spacing: 1
  onClicked: Hyprland.dispatch("exec pavucontrol") 
  icon: {
    // if ()<sink connected is headphones>) return '\uFA3C' || '\uEABD'
    if (AudioService.isMuted) return '\uF1C3'
    if (volumeAsInt > 45) return '\uEB51'
    if (volumeAsInt > 0)  return '\uEB4F'
    else return '\uEB50'
  }

  property int volumeAsInt: Math.round(AudioService.node.audio.volume * 100) 

  // Scroll event handler
  // The PwNode object must be referenced directly, using AudioService.volume here will not work. 
  mouseArea.onWheel: (wheelEvent) => {
    const step = 0.02
    if (wheelEvent.angleDelta.y > 0) {
      AudioService.node.audio.volume = Math.min(AudioService.node.audio.volume + step, 1)
    } 
    if (wheelEvent.angleDelta.y < 0) {
      AudioService.node.audio.volume = Math.max(AudioService.node.audio.volume - step, 0)
    }
  }
}

