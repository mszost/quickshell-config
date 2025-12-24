import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import qs.Theme


Item {
  id: root
  required property var boundItem  // the widget that this menu should appear under
  property bool menuIsOpen: false
  property int rowHeight: 21       // the height of each item in the ColumnLayout
  // property ShellScreen screen   // for calculating the screen width
  default property alias menuItems: content.data  // feeds into the ColumnLayout, defined by the widget implementing the template

  PopupWindow {
    id: menu
    anchor {  // this is a Quickshell property of PopupWindow, different from the native QML `anchors`.
      item: root.boundItem  // bind the location of this popup window to the BarWidget implementing it.
      edges: Edges.Bottom | Edges.Center
      gravity: Edges.Bottom | Edges.Center
      rect.y: 23
    }
    implicitWidth: 230
    implicitHeight: content.height + 40 // height is fitted to content + padding
    color: "transparent"
    visible: bgRect.y > -49 

    Rectangle {
      id: bgRect
      width: parent.width       // rectangle dimensions are fitted to the PopupWindow.
      height: parent.height -5  // trimming height by a few pixels prevents the bottom from getting cut off by the animation
      radius: 16
      color: Colors.applyAlpha(Colors.background,0.5)
      border.color: Colors.applyAlpha(Colors.foreground, 0.1)
      border.width: 1

      focus: true
      Keys.onEscapePressed: { root.menuIsOpen = false }

      // sliding in/out animation
      y: root.menuIsOpen ? 0 : -50
      Behavior on y {
        NumberAnimation { duration: 200; easing.type: Easing.OutBack}
      }

      ColumnLayout {
        id: content
        anchors.centerIn: parent
        width: parent.width
        spacing: 1
        property alias rowHeight: root.rowHeight
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

