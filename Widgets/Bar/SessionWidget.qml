import QtQuick

import Quickshell
import Quickshell.Hyprland

import qs.Theme
import qs.Components


BarWidgetLite {
  id: root
  // text: '\uEB0D' // tabler
  text: '\uE140'
  textFamily: Fonts.lucide.family
  textSize: Fonts.lucide.pixelSize
  hoverColor: Colors.red 

  onClicked: menuState = true

  property alias menuState: menu.menuIsOpen

  Menu {
    id: menu
    boundItem: root
    menuIsOpen: false

    MenuItem {
      text: "Session Management"
      textHoverColor: Colors.foreground  
      bgHoverColor: "transparent"
    }

    MenuItem {
      text: 'Log out'
      onClicked: Hyprland.dispatch('exec hyprctl exit')
    }
    
    MenuItem {
      text: 'Suspend'
      onClicked: Hyprland.dispatch('exec systemctl suspend')
    }
    
    MenuItem {
      text: 'Shutdown'
      onClicked: Hyprland.dispatch('exec shutdown now')
    }

    MenuItem {
      text: 'Reboot'
      onClicked: Hyprland.dispatch('exec reboot')
    }
  }
}
