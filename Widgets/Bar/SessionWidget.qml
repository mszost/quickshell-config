import qs.Theme
import qs.Components

BarWidget {
  id: root
  // icon: '\uEB0D' // tabler
  icon: '\uE140'
  iconFamily: Fonts.lucide.family
  iconSize: Fonts.lucide.pixelSize
  iconWeight: Fonts.lucide.weight
  hoverColor: Colors.red 

  // Menu {
  //   id: menu
  //   boundItem: root
  //   menuIsOpen: false
  //
  //   MenuItem {
  //     text: "Session Management"
  //     textHoverColor: Colors.foreground  
  //     bgHoverColor: "transparent"
  //   }
  //
  //   Rectangle {  // wrapper
  //     height: menu.rowHeight
  //     width: parent.width 
  //     color: "transparent"
  //     Rectangle {  // separator line
  //       height: 1
  //       width: parent.width * 0.75
  //       anchors.centerIn: parent
  //       color: Colors.applyAlpha(Colors.foreground,0.2)
  //     }
  //   }
  //
  //   MenuItem {
  //     text: 'Log out'
  //     onClicked: Hyprland.dispatch('exec hyprctl exit')
  //   }
  //
  //   MenuItem {
  //     text: 'Suspend'
  //     onClicked: Hyprland.dispatch('exec systemctl suspend')
  //   }
  //
  //   MenuItem {
  //     text: 'Shutdown'
  //     onClicked: Hyprland.dispatch('exec shutdown now')
  //   }
  //
  //   MenuItem {
 //     text: 'Reboot'
  //     onClicked: Hyprland.dispatch('exec reboot')
  //   }
  // }
}

