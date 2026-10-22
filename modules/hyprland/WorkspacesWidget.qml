import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs
import qs.style
import qs.components.common

Rectangle {
  id: root
  implicitHeight: Config.widget.pillHeight
  implicitWidth: wsRow.width + Config.widget.pillPaddingX
  radius: height
  color: Config.widget.pillColor
  
  // Shorthand for this widget's config object, because it's long
  readonly property QtObject cfg: Config.widget.workspaces 

  Row {
    id: wsRow
    anchors.centerIn: parent
    spacing: cfg.iconSpacing
    
    Repeater {
      model: Hyprland.workspaces

      Rectangle {
        id: wsIcon
        visible: cfg.showSpecialWorkspaces || modelData.id > 0
        implicitHeight: cfg.iconHeight
        implicitWidth: HyprService.isWorkspaceFocused(modelData.id) ? cfg.iconWidth * cfg.focusedIconScaleX : cfg.iconWidth
        radius: height
        color: {
          if (HyprService.isWorkspaceFocused(modelData.id)) return Colors.primary  
          if (HyprService.isWorkspaceOccupied(modelData.id)) return Colors.secondary
          else return Colors.surface
        }
        antialiasing: true

        Behavior on color { ColorAnim {} }
        Behavior on implicitWidth { Anim { kind: Motion.Bounce } }

        Text {
          anchors.fill: parent
          visible: { cfg.showWorkspaceId 
            && (HyprService.isWorkspaceOccupied(modelData.id)
            || HyprService.isWorkspaceFocused(modelData.id))
          }
          horizontalAlignment: Text.AlignHCenter
          font.family: Config.fontMono.family
          font.pixelSize: cfg.iconHeight * 0.7
          font.weight: 700
          text: modelData.id > 0 ? modelData.id : ''
        }
      }
    }
  }
}

