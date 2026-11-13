import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs
import qs.style
import qs.components

Rectangle {
  id: root
  implicitHeight: Config.widget.pillHeight
  implicitWidth: wsRow.width + Config.widget.pillPaddingX
  radius: height
  color: Config.widget.pillColor
  
  readonly property QtObject cfg: Config.module.workspaces 

  Row {
    id: wsRow
    anchors.centerIn: parent
    spacing: cfg.dotSpacing
    
    Repeater {
      model: Hyprland.workspaces

      Rectangle {
        id: wsDot
        visible: cfg.showSpecialWorkspaces || modelData.id > 0
        implicitHeight: cfg.dotHeight
        implicitWidth: HyprService.isWorkspaceFocused(modelData.id) ? cfg.dotWidth * cfg.focusedDotScaleX : cfg.dotWidth
        radius: height
        color: {
          if (HyprService.isWorkspaceFocused(modelData.id)) return Colors.primary  
          if (HyprService.isWorkspaceOccupied(modelData.id)) return Colors.secondary
          else return Colors.surface
        }
        antialiasing: true
 
        Ease on implicitWidth {}
        Ease on color {}

        // Text {
        //   anchors.fill: parent
        //   visible: { cfg.showWorkspaceId 
        //     && (HyprService.isWorkspaceOccupied(modelData.id)
        //     || HyprService.isWorkspaceFocused(modelData.id))
        //   }
          // horizontalAlignment: Text.AlignHCenter
          // font.family: Config.fontMono.family
          // font.pixelSize: cfg.iconHeight * 0.7
          // font.weight: 700
          // text: modelData.id > 0 ? modelData.id : ''
        // }
      }
    }
  }
}

