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

    Row { 
      id: wsRow
      anchors.centerIn: parent
      spacing: 5

      Repeater {
        model: [1,2,3,4,5,6]  //HyprlandService.workspaceIds
        Rectangle { 
          id: wsIcon
          height: 13
          width: HyprlandService.isWorkspaceFocused(index+1) ? height*2 : height
          radius: width/2
          color: workspaceStateColor
          border.width: 1
          border.color: Colors.alpha(Colors.shadow, 0.1)
          antialiasing: true
        
          property color workspaceStateColor: {
            if (HyprlandService.isWorkspaceFocused(index+1)) return Colors.primary  
            if (HyprlandService.isWorkspaceOccupied(index+1)) return Colors.secondary
            else return Colors.alpha(Colors.shadow, 0.75)
          }

          Behavior on color { ColorAnimation { duration: 150; easing.type: Easing.InOutQuad } }
          Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }

        }
      }
    }
  }
}

