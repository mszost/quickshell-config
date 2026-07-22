import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs
import qs.style

Rectangle {
  id: bgRect
  implicitWidth: wsRow.implicitWidth + 28
  implicitHeight: Config.barPillHeight //wsRow.implicitHeight
  anchors.verticalCenter: parent.verticalCenter
  radius: height
  color: 'transparent'

  Row { 
    id: wsRow
    anchors.centerIn: parent
    spacing: 4

    Repeater {
      model: [1,2,3,4,5,6] //Hyprland.workspaces

      Rectangle { 
        id: wsIcon
        height: 13
        width: HyprService.isWsFocused(modelData) ? height*2 : height
        radius: width/2
        border.color: Colors.alpha(Colors.shadow, 0.25)
        antialiasing: true
      
        color: {
          if (HyprService.isWsFocused(modelData)) return Colors.primary  
          if (HyprService.isWsOccupied(modelData)) return Colors.secondary
          else return Colors.shadow
        }

        Behavior on color { ColorAnimation { 
          duration: 150; easing.type: Easing.InOutQuad 
        }}

        Behavior on width { NumberAnimation { 
          duration: 290
          easing.type: Easing.OutBack 
          easing.overshoot: 2.8
        }}

        Text {
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          text: Config.workspacesShowId ? modelData : ''
          font.family: Fonts.cartograph.family
          font.weight: 600 
          font.pixelSize: 7
        }
      }
    }
  }
}

