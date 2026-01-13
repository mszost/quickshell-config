// Popup indicator that appears when changing values for things like volume and backlight
// Based on https://github.com/quickshell-mirror/quickshell-examples/volume-osd

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Widgets

import qs.Theme
import qs.Components
import qs.Services


Scope {
  id: root
  
  required property real level
  required property string icon
  property bool isVisible: false

  onLevelChanged: {
    root.isVisible = true
    hideTimer.restart()
  }

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: root.isVisible = false
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      anchors.bottom: true
      margins.bottom: screen.height / 5
      exclusiveZone: 0
      mask: Region {}  // An empty click mask prevents the window from blocking mouse events

      implicitWidth: 250
      implicitHeight: 40
      color: 'transparent'

      screen: modelData
      property var modelData

      visible: Hyprland.focusedMonitor?.name == modelData.name

      Rectangle {
        id: bgRect
        implicitWidth: parent.width -2
        implicitHeight: parent.height -2
        radius: 12
        color: Colors.alpha(Colors.background, 0.33)

        // pop in/out animation
        scale: root.isVisible ? 1 : 0
        Behavior on scale { NumberAnimation { duration: 100; easing.type: Easing.InOutBack } }

        RowLayout {
          anchors { fill: parent; leftMargin: 10; rightMargin: 15 }
          Text {
            id: icon 
            text: root.icon
            font.family: Fonts.barIcon.family
            font.pixelSize: 24
            color: Colors.foreground
          }
          
          Rectangle {
            Layout.fillWidth: true
            implicitHeight: 8
            radius: height/2
            color: Colors.alpha(Colors.foreground, 0.33) 
            
            Rectangle {
              anchors { 
                left: parent.left
                top: parent.top
                bottom: parent.bottom 
              }
              width: Math.min(parent.width, (parent.width * root.level))
              radius: parent.radius
              color: Colors.foreground
                
              Behavior on width { 
                NumberAnimation { duration: 300; easing.type: Easing.OutBack; }
              }  
            }
          }
        }
      }
    }
  }
}
