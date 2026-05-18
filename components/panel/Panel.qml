// Intended to be attached to an instance of BarWidget.
// See modules/audio/AudioPanel.qml

import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs
import qs.style

Scope {
  id: root
  default property alias menuContent: column.data
  required property var boundItem  // the widget that this panel should appear under
  required property var widgetContainerPos

  property int width: 375
  readonly property int radius: 16
  readonly property int padding: 12
  readonly property int yOffset: 27
  // Sets a minimum distance from the sides of the screen
  readonly property int xOffset: switch (widgetContainerPos) {
    case ('right'): return -50
    case ('left'): return 50
    default: return 20
  } 

  readonly property real bgAlpha: Config.panelContainerAlpha ?? Config.alpha ?? 1.0
  
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
          // Wait for animation to finish before toggling visibility
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
        spacing: 10
      }
    }
  }
}

