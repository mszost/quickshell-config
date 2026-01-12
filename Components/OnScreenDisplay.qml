// Popup indicator that appears when changing values for things like volume and backlight
// Based on https://github.com/quickshell-mirror/quickshell-examples/volume-osd

import QtQuick
import QtQuick.Layouts

import Quickshell
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

  PanelWindow {
    anchors.bottom: true
    margins.bottom: screen.height / 5
    exclusiveZone: 0
    mask: Region {}  // An empty click mask prevents the window from blocking mouse events

    implicitWidth: 250
    implicitHeight: 40
    color: 'transparent'

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
          implicitHeight: 10
          radius: height/2
          color: Colors.alpha(Colors.foreground, 0.33) 
          
          OsdLevelRect { level: root.level }
        }
      }
    }
  }
}
