import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import qs.Theme


Item {
  id: root
  property bool menuIsOpen: false
  required property var boundItem
  default property alias menuItems: content.data
  property ShellScreen screen
  
  PopupWindow {
    id: menu
    anchor { // this is a Quickshell property of PopupWindow, different from the native QML `anchors`.
      item: root.boundItem // bind the location of this popup window to the BarWidget implementing it.
      edges: Edges.Bottom | Edges.Center
      gravity: Edges.Bottom | Edges.Center
      rect.y: 23
    }
    implicitWidth: 200
    implicitHeight: content.height + 20 // height is fitted to content + padding
    color: "transparent"
    visible: bgRect.y > -39 

    Rectangle {
      id: bgRect
      width: parent.width  // rectangle dimensions are fitted to the PopupWindow.
      height: parent.height 
      radius: 15
      color: Colors.applyAlpha(Colors.background,0.8)
      border.color: Colors.applyAlpha(Colors.foreground, 0.3)
      border.width: 1

      focus: true
      Keys.onEscapePressed : { root.menuIsOpen = false }

      // sliding in/out animation
      y: root.menuIsOpen ? 0 : -40
      Behavior on y {
        NumberAnimation { duration: 275; easing.type: Easing.OutBack}
      }

      ColumnLayout {
        id: content
        anchors.centerIn: parent // centered in the Rectangle.
        
        width: parent.width -10  // dimensions fitted to Rectangle, and provides some padding to each row.
        spacing: 1
      } 
    }

    HyprlandFocusGrab {
      id: grab
      windows: [ menu ]
      active: root.menuIsOpen
      onCleared: root.menuIsOpen = false
    }
  }
}

