import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.Widgets.Bar
import qs.Theme
import qs.Services

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      screen: modelData
      implicitHeight: 32
      color: 'transparent' 
      property var modelData
      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle {  
        color: Colors.applyAlpha(Colors.background, 0.6)  
        radius: 9
        antialiasing: true
        anchors {
          fill: parent
          leftMargin: 10
          rightMargin: 10
          topMargin: 2
          // bottomMargin: 1
        }

        RowLayout { 
          spacing: 12
          anchors {
            fill: parent
            leftMargin: 16
            rightMargin: 16
          }
          //PanelButton { Layout.alignment: Qt.AlignLeft }
          //TrayWidget {}
          //Tray { Layout.alignment: Qt.AlignLeft } 
          ClockWidget {} //{ Layout.alignment: Qt.AlignLeft }
          Item { Layout.fillWidth: true } // Spacer 
          Sunset { Layout.alignment: Qt.AlignRight }
          // TestWidget { Layout.alignment: Qt.AlignRight }
          VolumeWidget { Layout.alignment: Qt.AlignRight }
          NetworkWidget { Layout.alignment: Qt.AlignRight }
          // BacklightWidget { Layout.alignment: Qt.AlignRight }
          BatteryWidget { Layout.alignment: Qt.AlignRight }
          SessionWidget { Layout.alignment: Qt.AlignRight }
        }

        // This item is a child of Rectangle, outside of RowLayout, so that it can be 
        // positioned in the absolute center and independently of any other items in the row.
          WorkspacesWidget { anchors.centerIn: parent}
      }
    }
  }
}

