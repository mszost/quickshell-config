import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

import qs.Theme
import qs.Components


Scope {
  id: root
  property bool isVisible: true 

  PanelWindow {
    id: panel
    anchors { right: true; left: true; top: true; bottom: true} // cover the entire screen
    exclusiveZone: 0
    visible: root.isVisible
    color: 'transparent'

    Rectangle {
      id: bgRect
      anchors.fill: parent
      color: Colors.alpha(Colors.background, 0.3)

      MouseArea { anchors.fill: parent; onClicked: root.isVisible = false }

      GridLayout {
        id: grid
        anchors.centerIn: parent
        columns: 2
        rowSpacing: 15
        columnSpacing: 15
        
        Repeater {
          model: [1,2,3,4]
          
          Rectangle {
            id: buttonRect
            Layout.fillHeight: true
            Layout.fillWidth: true
            width: 250
            height: 250
            radius: width * 0.1
            color: Colors.background
            border.width: 1 
            border.color: Colors.alpha(Colors.foreground, 0.1)
            antialiasing: true

            Rectangle {
              anchors.top: parent.top
              anchors.right: parent.right
              anchors.margins: 15
              width: 15
              height: 15
              radius: width * 0.33
              color: 'transparent'
              border.color: Colors.debug
              antialiasing: true
            }
          }
        }
      }
    }
  }
}

