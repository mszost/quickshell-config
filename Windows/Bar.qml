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
      id: barWindow
      anchors { top: true; left: true; right: true }
      implicitHeight: 29
      color: 'transparent' 
      visible: modelData.name == 'eDP-2' || modelData.name == 'DP-10' || modelData.name == "HDMI-1"
      
      screen: modelData
      property var modelData

      Rectangle {  
        anchors { fill: parent; leftMargin: 10; rightMargin: 10 }
        color: Colors.alpha(Colors.background, 0.5)  
        radius: 9
        antialiasing: true

        RowLayout {
          anchors { fill: parent; leftMargin: 16; rightMargin: 16 }
          spacing: 8

          WorkspacesWidget {} 

          Item { Layout.fillWidth: true } // Spacer 
          
          Sunset { Layout.alignment: Qt.AlignRight }
          VolumeWidget { Layout.alignment: Qt.AlignRight }
          NetworkWidget { Layout.alignment: Qt.AlignRight }
          BatteryWidget { Layout.alignment: Qt.AlignRight }
          SessionWidget {Layout.alignment: Qt.AlignRight}
        }

        // This item is a child of Rectangle, outside of RowLayout, so that it can be 
        // positioned in the absolute center and independently of any other items in the row.
        ClockWidget { id:workspaces; anchors.centerIn: parent }
      }
    }
  }
}

