// Popup indicator that appears on changes to things like volume and backlight
// Based on https://github.com/quickshell-mirror/quickshell-examples/volume-osd
// See Windows/OsdManager.qml

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
  required property string label
  property bool isVisible: false
  property bool shouldShowOsd: true

  readonly property int padding: 12

  onLevelChanged: {
    root.isVisible = root.shouldShowOsd
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
      margins.bottom: screen.height/6 
      exclusiveZone: 0
      mask: Region {}  // An empty click mask prevents the window from blocking mouse events

      implicitWidth: 180
      implicitHeight: 50
      color: 'transparent'

      screen: modelData
      property var modelData

      visible: Hyprland.focusedMonitor?.name == modelData.name

      Rectangle {
        id: bgRect
        implicitWidth: parent.width -2  // padding for scale animation
        implicitHeight: parent.height -2
        radius: height
        color: Colors.alpha(Colors.background, 0.75)

        // pop in/out animation
        scale: root.isVisible ? 1 : 0
        Behavior on scale { NumberAnimation { duration: 100; easing.type: Easing.InOutBack } }

        RowLayout {
          anchors { fill: parent; leftMargin: root.padding; rightMargin: root.padding }
          spacing: root.padding

          Text {
            id: icon
            Layout.alignment: Qt.AlignLeft
            text: root.icon
            font: Fonts.osdIcon
            color: Colors.foreground
          }

          Column {
            Layout.fillWidth: true
            spacing: 4
            Layout.bottomMargin: 6

            RowLayout {
              width: parent.width
              Text {
                Layout.alignment: Qt.AlignLeft
                // Layout.leftMargin: root.padding
                text: root.label
                font: Fonts.osdLabel
                color: Colors.foreground
              }

              Text {
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: root.padding
                text: Math.round(level*100)
                font: Fonts.osdLabel
                color: root.level > 1 ? Colors.red : Colors.foreground
              }
            }

            Rectangle { 
              width: parent.width - root.padding
              height: 5
              radius: height
              color: 'transparent' //Colors.alpha(Colors.debug, 0.25)

              Rectangle {
                id: valueRect
                anchors.left: parent.left
                width: Math.min(parent.width, (parent.width * root.level))
                height: parent.height
                radius: height
                color: Colors.foreground
                Behavior on width { NumberAnimation { 
                  duration: 350
                  easing.type: Easing.OutBack
                }}  
              }

              Rectangle {
                anchors.right: parent.right
                width: parent.width - valueRect.width - 3
                height: parent.height
                radius: height
                color: Colors.surfaceBright
              }

              Rectangle {
                anchors.right: parent.right
                width: 5
                height: parent.height
                radius: height
                color: root.level > 1 ? Colors.red : Colors.foreground
              }
            }


          }
        }

        // RowLayout {
        //   anchors { fill: parent; leftMargin: 10; rightMargin: 15 }
        //   Text {
        //     id: icon 
        //     text: root.icon
        //     font.family: Fonts.barIcon.family
        //     font.pixelSize: 24
        //     color: Colors.foreground
        //   }
        //
        //   Rectangle {
        //     Layout.fillWidth: true
        //     implicitHeight: 8
        //     radius: height/2
        //     color: Colors.surfaceDim
        //
        //     Rectangle {
        //       anchors { 
        //         left: parent.left
        //         top: parent.top
        //         bottom: parent.bottom 
        //       }
        //       width: Math.min(parent.width, (parent.width * root.level))
        //       radius: parent.radius
        //       color: Colors.foreground
        //
        //       Behavior on width { NumberAnimation { 
        //         duration: 350
        //         easing.type: Easing.OutBack
        //       }}  
        //     }
        //   }
        // }
      }
    }
  }
}
