// Template for a drop-down context menu.
// Intended to be attached to an instance of BarWidget.
// See Widgets/Menus/

import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.Theme


Scope {
  id: root
  required property var boundItem  // the widget that this menu should appear under
  default property alias menuContent: column.data  // provided by files implementing this component

  property int padding: 10
  property int yOffset: 25
  property int width: 350
  property int radius: 8

  property bool isVisible: false
  onIsVisibleChanged: focusGrab.active = isVisible

  PopupWindow {
    id: popup
    anchor {
      item: root.boundItem
      edges: Edges.Bottom | Edges.Center
      gravity: Edges.Bottom | Edges.Center
      rect.y: root.yOffset
    }
    implicitWidth: root.width
    implicitHeight: bgRect.height 
    color: 'transparent'

    // Wait for the animation to finish before visible can be false
    visible: root.isVisible || (bgRect.y > -1*bgRect.height)

    HyprlandFocusGrab {
      id: focusGrab
      windows: [popup]
      onActiveChanged: { if (!active) root.isVisible = false }
    }
    
    Rectangle { 
      id: bgRect
      width: parent.width
      height: column.height + (root.padding * 2)
      radius: 10 
      color: Colors.surfaceDim

      focus: true 
      Keys.onEscapePressed: root.isVisible = false

      // Slide in/out animation
      y: isVisible ? 0 : (-1 * height)
      Behavior on y { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } 
      }

      Column {
        id: column
        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
          margins: root.padding
        }
        spacing: root.padding
      }
    }
  }
}

