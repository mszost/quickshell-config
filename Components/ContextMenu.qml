// Template for a drop-down context menu.
// Intended to be attached to an instance of BarWidget.
// See Widgets/Menus/

import QtQuick

import Quickshell
import Quickshell.Hyprland

import qs
import qs.Theme


Scope {
  id: root
  default property alias menuContent: column.data  // provided by files implementing this component
  required property var boundItem  // the widget that this menu should appear under

  property int padding: 10
  property int yOffset: 25
  property int width: 350
  property int radius: 10

  property bool isVisible: false
  onIsVisibleChanged: focusGrab.active = isVisible

  readonly property real bgAlpha: Config.menuContainerAlpha ?? Config.alpha ?? 1.0


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

    visible: root.isVisible || animatingOut
    property bool animatingOut: false

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
      color: Colors.alpha(Colors.surfaceDim, root.bgAlpha)

      focus: true 
      Keys.onEscapePressed: root.isVisible = false

      // Slide in/out animation
      y: root.isVisible ? 0 : (-1 * height)
      Behavior on y { 
        NumberAnimation { 
          duration: 300
          easing.type: Easing.OutExpo
          onRunningChanged: {
            if (!running && !root.isVisible) {
              popup.animatingOut = false
            } else if (running && !root.isVisible) {
              popup.animatingOut = true
            }
          }
        } 
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

