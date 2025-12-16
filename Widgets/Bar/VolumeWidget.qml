import QtQuick

import Quickshell
import Quickshell.Hyprland

import qs.Theme
import qs.Components
import qs.Services


BarWidget {
  id: root
  text: AudioService.isMuted ? 'Muted' : AudioService.volumeAsInt + '%'
  iconSize: 18
  spacing: 1
  onClicked: menuState = !menuState //Hyprland.dispatch("exec pavucontrol") 
  normalColor: AudioService.volumeAsInt > 100 ? Colors.red : Colors.foreground
  icon: {
    // if (<sink connected is headphones>) return '\uFA3C' || '\uEABD'
    if (AudioService.isMuted) return '\uF1C3'
    if (AudioService.volumeAsInt > 45) return '\uEB51'
    if (AudioService.volumeAsInt > 0)  return '\uEB4F'
    else return '\uEB50'
  }

  property alias menuState: menu.menuIsOpen

  BarMenu {
    id: menu
    boundItem: root
    menuIsOpen: root.menuState

    BarMenuItem {
      text: "Mute"
      onClicked: console.log('BarMenuItem clicked: "Mute"')
    }

    BarMenuItem {
      text: "Open Mixer"
      onClicked: console.log('BarMenuItem clicked: "Open Mixer"')
      // root.menuState: false  // close the menu
    }
    
    Rectangle {  // You can even add standard QML items 
      height: 1
      width: parent.width - 20
      color: Colors.applyAlpha(Colors.foreground,0.2)
      opacity: 0.5
    }

  }

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

