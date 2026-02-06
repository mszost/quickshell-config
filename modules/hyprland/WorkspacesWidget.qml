import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import qs.style


Rectangle {
  id: bgRect
  implicitWidth: wsRow.implicitWidth
  implicitHeight: wsRow.implicitHeight
  anchors.verticalCenter: parent.verticalCenter

  radius: 8
  color: 'transparent'

  Row { 
    id: wsRow
    // anchors.verticalCenter: parent.verticalCenter
    spacing: 5

    Repeater {
      model: [1,2,3,4,5,6]  //HyprlandService.workspaceIds
      Rectangle { 
        id: wsIcon
        height: 13
        width: HyprService.isWsFocused(modelData) ? height*2 : height
        radius: width/2
        border.width: 1
        border.color: Colors.alpha(Colors.shadow, 0.1)
        antialiasing: true
      
        color: {
          if (HyprService.isWsFocused(modelData)) return Colors.primary  
          if (HyprService.isWsOccupied(modelData)) return Colors.secondary
          else return Colors.surfaceDim
        }

        Behavior on color { ColorAnimation { 
          duration: 100
          easing.type: Easing.OutInQuad 
        }}
        Behavior on width { NumberAnimation { 
          duration: 400
          easing.type: Easing.OutBack 
          easing.overshoot: 3
        }}
      }
    }
  }
}

