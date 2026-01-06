import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.Services
import qs.Theme


Item {
  id: root
  // anchors.verticalCenter: parent.verticalCenter
  implicitWidth: wsRow.implicitWidth
  implicitHeight: wsRow.implicitHeight

  Rectangle {
    id: wsBackground
    anchors {
      fill: parent
      margins: -10
      topMargin: -5
      bottomMargin: -5
    }

    radius: 8
    color: 'transparent' //Colors.applyAlpha(Colors.background,0.5)

    // border.width: 1
    // border.color: Theme.background

    Row { 
      id: wsRow
      anchors.centerIn: parent
      spacing: 6

      Repeater {
        model: [1,2,3,4,5,6]  //HyprlandService.workspaceIds
        Rectangle { 
          id: wsIcon
          height: 12
          width: 12
          radius: width/2 
          color: workspaceStateColor
          border.width: 1
          border.color: Colors.alpha(Colors.background, 0.15)
          antialiasing: true
        
          property color workspaceStateColor: {
            if (HyprlandService.isWorkspaceFocused(index + 1)) return Colors.primary  
            if (HyprlandService.isWorkspaceOccupied(index + 1)) return Colors.alpha(Colors.primary, 0.25)
            else return Colors.alpha(Colors.background, 0.75)
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

