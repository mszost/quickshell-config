import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.Services
import qs.Theme


Item {
  id: root
  implicitWidth: wsRow.implicitWidth
  implicitHeight: wsRow.implicitHeight

  Rectangle {
    id: wsBackground
    anchors {
      fill: parent
      margins: -10
      topMargin: -7
      bottomMargin: -7
    }

    radius: 8
    color: Colors.applyAlpha(Colors.background,0.4)
    // border.width: 1
    // border.color: Theme.background

    Row { 
      id: wsRow
      anchors.centerIn: parent
      spacing: 6

      Repeater {
        model: [1,2,3,4,5,6]  //HyprlandService.workspaceIds
        Rectangle { // workspace icon
          id: wsBox
          height: 11
          width: 11
          radius: width/2 
          color: workspaceStateColor 
        
          // using modelData will reference the list contents instead of just the index. 
          property color workspaceStateColor: {
            if (HyprlandService.isWorkspaceFocused(index + 1)) return Colors.color2  
            if (HyprlandService.isWorkspaceOccupied(index + 1)) return Colors.applyAlpha(Colors.color2, 0.25)
            else return Colors.applyAlpha(Colors.background, 0.5)
          }

          Behavior on color {
            ColorAnimation {
              duration: 200 
              easing.type: Easing.InOutQuad
            }
          }
        }
      }
    }
  }
}
