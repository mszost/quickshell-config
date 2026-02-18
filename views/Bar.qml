import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import Quickshell
import qs
import qs.style
import qs.modules.audio
import qs.modules.battery
import qs.modules.backlight
import qs.modules.hyprland
import qs.modules.network
import qs.modules.pkgupdates
import qs.modules.session
import qs.modules.time
import qs.modules.tray

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

      Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InOutCirc }}

      Rectangle {  
        id: bgRect
        anchors { fill: parent; topMargin: padY; leftMargin: padX; rightMargin: padX }
        radius: bgRadius
        antialiasing: true
        color: Colors.alpha(Config.barColorBg, bgAlpha)

        // State handler: on change to panel.shouldTile, sleep before updaing dimensions
        states: State {
          name: 'occupied'
          when: panel.shouldTile
          PropertyChanges { 
            target: bgRect
            padX: 0; padY: 0; bgRadius: 0; height: 0 
          }
        }
        transitions: Transition {
          from: 'occupied'
          to: '*'
          SequentialAnimation {
            PauseAnimation { duration: 200 }
            PropertyAction { properties: 'padX', 'padY', 'bgRadius', 'height' }
          }
        }

        property real bgAlpha: panel.shouldTile ? Config.barAlpha : Config.barAlphaFloating ?? Config.alpha ?? 1.0
        property int bgRadius: Config.barCornerRadius
        property int padX: Config.barHorizontalOffset
        property int padY: Config.barVerticalOffset

        // looks glitchy because the height is being updated before the padding.
        Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InOutCirc }}
        Behavior on bgAlpha { NumberAnimation { duration: 300; easing.type: Easing.OutQuad }}
        Behavior on radius { NumberAnimation { duration: 600; easing.type: Easing.OutQuad }}
        Behavior on anchors.topMargin { NumberAnimation { duration: 300; easing.type: Easing.InOutCirc }}
        Behavior on anchors.leftMargin { NumberAnimation { duration: 300; easing.type: Easing.InOutCubic }}
        Behavior on anchors.rightMargin { NumberAnimation { duration: 300; easing.type: Easing.InOutCubic }}


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
              spacing: 9
              readonly property var position: 'left'
              
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
              readonly property var position: 'right'

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

