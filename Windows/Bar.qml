import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.Widgets.Bar
import qs.Theme


Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      anchors { top: true; left: true; right: true }
      implicitHeight: 36
      color: 'transparent' 
      visible: ['eDP-2', 'DP-10', 'HDMI-1'].includes(modelData.name)
      
      screen: modelData
      property var modelData

      Rectangle {  
        id: bgRect
        anchors { fill: parent; topMargin: 3; leftMargin: 10; rightMargin: 10 }
        radius: 10
        color: Colors.alpha(Colors.background, 0.75)  
        antialiasing: true

        RowLayout {
          anchors { fill: parent; leftMargin: 16; rightMargin: 16 }
          spacing: 8

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

