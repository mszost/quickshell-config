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
    spacing: 5

    Repeater {
      model: [1,2,3,4,5,6,7]

      Rectangle { 
        id: wsIcon
        height: 14
        width: HyprService.isWsFocused(modelData) ? height*2 : height
        radius: width/2
        border.color: Colors.alpha(Colors.surfaceDim, 0.25)
        antialiasing: true
      
        color: {
          if (HyprService.isWsFocused(modelData)) return Colors.primary  
          if (HyprService.isWsOccupied(modelData)) return Colors.secondary
          else return Colors.surfaceDim
        }

        Behavior on width { NumberAnimation { 
          duration: 375
          easing.type: Easing.OutBack 
          easing.overshoot: 2.5
        }}
      }
    }
  }
}

