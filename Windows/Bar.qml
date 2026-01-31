import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import qs
import qs.Theme
import qs.Services
import qs.Widgets.Bar


Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      anchors { top: true; left: true; right: true }
      implicitHeight: Config.barHeight + bgRect.padY
      color: 'transparent' 
      visible: Config.barMonitors.includes(modelData.name)
      
      screen: modelData
      property var modelData
      readonly property bool shouldTile: {
        !Config.barDynamic || HyprService.isWsTiled(HyprService.getWsForScreen(modelData))
      }

      Rectangle {  
        id: bgRect
        anchors { fill: parent; topMargin: padY; leftMargin: padX; rightMargin: padX }
        radius: bgRadius
        color: Colors.alpha(Config.barColorBg, bgAlpha) 
        antialiasing: true

        // Animation handler
        states: State {
          name: 'occupied'
          when: panel.shouldTile
          PropertyChanges { 
            target: bgRect
            padX: 0; padY: 0; bgRadius: 0 
          }
        }
        transitions: Transition {
          from: 'occupied'
          to: '*'
          SequentialAnimation {
            PauseAnimation { duration: 300 }
            PropertyAction { properties: 'root', 'root', 'bgRadius' }
          }
        }

        property real bgAlpha: panel.shouldTile ? Config.barAlpha : Config.barAlphaFloating ?? Config.alpha ?? 1.0
        property int bgRadius: Config.barCornerRadius
        property int padX: Config.barHorizontalOffset
        property int padY: Config.barVerticalOffset

        // looks glitchy because the height is being set before the padding.
        // Behavior on height { NumberAnimation { duration: 100; easing.type: InOutQuad } }
        Behavior on bgAlpha { NumberAnimation { duration: 300; easing.type: Easing.OutQuad } }
        Behavior on radius { NumberAnimation { duration: 1000; easing.type: Easing.OutCirc } }
        Behavior on anchors.topMargin { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        Behavior on anchors.leftMargin { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        Behavior on anchors.rightMargin { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad} }


        RowLayout {
          anchors { fill: parent; leftMargin: 16; rightMargin: 16 }
          
          Rectangle {
            implicitHeight: Config.barHeight
            implicitWidth: rowLeft.width
            color: 'transparent'
            // border.color: Colors.debug

            Row {
              id: rowLeft
              anchors.verticalCenter: parent.verticalCenter
              spacing: 10
              WorkspacesWidget {}
              UpdatesWidget {}
            }
          }

          Rectangle {
            Layout.alignment: Qt.AlignRight 
            implicitHeight: Config.barHeight
            implicitWidth: rowRight.width
            color: 'transparent'
            // border.color: Colors.debug

            Row {
              id: rowRight
              anchors.verticalCenter: parent.verticalCenter
              spacing: 9

              SysTrayWidget {} 
              BacklightWidget {}
              NetworkWidget {}
              AudioWidget {}
              BatteryWidget {}
              SessionWidget {}
            }
          }
        }

        Rectangle {
          anchors.centerIn: parent
          implicitHeight: Config.barHeight
          implicitWidth: rowCenter.width
          color: 'transparent'
          // border.color: Colors.debug
          
          Row {
            id: rowCenter
            anchors.verticalCenter: parent.verticalCenter
            ClockWidget {}
          }
        }
      }
    }
  }
}

