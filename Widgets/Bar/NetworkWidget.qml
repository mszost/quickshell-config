import QtQuick

import Quickshell

import qs.Components
import qs.Services
import qs.Theme


BarWidget {
  id: root
  icon: '\ueb52'// '\ueb9d' //'\uEB54' 
  iconSize: 18
  onClicked: menuState = true //console.log(Quickshell.screens[2]) 

  property alias menuState: menu.menuIsOpen

  Menu {
    id: menu
    boundItem: root
    menuIsOpen: false

    MenuItem {
      text: "Network"
      textHoverColor: Colors.foreground  
      bgHoverColor: "transparent"
    }


    MenuItem {
      text: "SSID: Red5Blue"
      textHoverColor: Colors.foreground  
      bgHoverColor: "transparent"
    }
    MenuItem {
      text: "interface: wlan0"
      textHoverColor: Colors.foreground  
      bgHoverColor: "transparent"
    }
    MenuItem {
      text: "IP: 10.0.0.232"
      textHoverColor: Colors.foreground  
      bgHoverColor: "transparent"
    }
    MenuItem {
      text: "Signal Str: 9/10"
      textHoverColor: Colors.foreground  
      bgHoverColor: "transparent"
    }
  }
}

