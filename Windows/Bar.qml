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
      implicitHeight: 35 + bgRect.padY
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
        color: Colors.alpha(Colors.background, bgAlpha) 
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
            PauseAnimation { duration: 375 }
            PropertyAction { properties: 'root', 'root', 'bgRadius' }
          }
        }

        property real bgAlpha: panel.shouldTile ? 1.0 : Config.barAlpha ?? Config.alpha ?? 1.0
        property int bgRadius: Config.barCornerRadius
        property int padX: Config.barHorizontalOffset
        property int padY: Config.barVerticalOffset

        Behavior on bgAlpha { NumberAnimation { duration: 600; easing.type: Easing.OutQuad } }
        Behavior on radius { NumberAnimation { duration: 400; easing.type: Easing.OutCirc } }
        Behavior on anchors.topMargin { NumberAnimation { duration: 350; easing.type: Easing.OutQuad } }
        Behavior on anchors.leftMargin { NumberAnimation { duration: 350; easing.type: Easing.OutQuad } }
        Behavior on anchors.rightMargin { NumberAnimation { duration: 350; easing.type: Easing.OutQuad } }

        RowLayout {
          anchors { fill: parent; leftMargin: 16; rightMargin: 16 }
          spacing: 9

          WorkspacesWidget {}
          UpdatesWidget {}

          Item { Layout.fillWidth: true } // Spacer 
          
          Hyprsunset { Layout.alignment: Qt.AlignRight }
          NetworkWidget { Layout.alignment: Qt.AlignRight }
          AudioWidget { Layout.alignment: Qt.AlignRight }
          BatteryWidget { Layout.alignment: Qt.AlignRight }
          SessionWidget { Layout.alignment: Qt.AlignRight }
        }

        // This item is a child of Rectangle, outside of RowLayout, so that it can be 
        // positioned in the absolute center and independently of any other items in the row.
        ClockWidget { anchors.centerIn: parent }
      }
    }
  }
}

