// Template for a drop-down context menu.
// Intended to be attached to an instance of BarWidget.
// See modules/audio/AudioMenu.qml

import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs
import qs.style

Scope {
  id: root
  default property alias menuContent: column.data  // provided by files implementing this component
  required property var boundItem  // the widget that this menu should appear under
  required property var widgetContainerPos

  readonly property int width: 350
  readonly property int radius: 16
  readonly property int padding: 12
  readonly property int yOffset: 26
  // Sets a minimum distance from the sides of the screen
  readonly property int xOffset: switch (widgetContainerPos) {
    case ('right'): return -45
    case ('left'): return 45
    default: return 20
  } 

  readonly property real bgAlpha: Config.menuContainerAlpha ?? Config.alpha ?? 1.0
  
  property bool isVisible: false
  onIsVisibleChanged: focusGrab.active = isVisible


  PopupWindow {
    id: popup
    anchor {
      item: root.boundItem
      edges: Edges.Bottom | Edges.Center
      gravity: Edges.Bottom | Edges.Center
      rect.y: root.yOffset
      rect.x: root.xOffset 
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
      // radius: root.radius /
      bottomLeftRadius: root.radius
      bottomRightRadius: root.radius
      color: Colors.alpha(Colors.surfaceDim, root.bgAlpha)

      focus: true 
      Keys.onEscapePressed: root.isVisible = false

      // Slide in/out animation
      y: root.isVisible ? 0 : (-1 * height)
      Behavior on y { 
        NumberAnimation { 
          duration: 250
          easing.type: Easing.InOutCirc
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
        spacing: 11
      }
    }
  }
}

