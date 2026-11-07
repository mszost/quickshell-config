import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs
import qs.style
import qs.components.common
import qs.components.dock
import qs.modules.core
import qs.modules.hyprland

Scope { 
  id: root

  readonly property QtObject cfg: Config.dock
  readonly property bool showSeparatorLine: root.unpinnedOpenApps.length > 0
  readonly property real iconSize: cfg.height - (2 * cfg.iconRowPadding) - cfg.dotGap - cfg.dotSize
  readonly property real pinnedAppsWidth: cfg.pinnedApps.length * (iconSize + cfg.iconSpacing) + 2 * cfg.iconRowPadding
  readonly property real openedAppsWidth: unpinnedOpenApps.length * (iconSize + cfg.iconSpacing) + 2 * cfg.iconRowPadding
  readonly property real totalDockWidth: pinnedAppsWidth + openedAppsWidth + (showSeparatorLine ? cfg.separatorLineWidth : 0) + 2 * cfg.hoverZoneMargin
  readonly property real displacement: cfg.height + cfg.bottomMargin

  readonly property list<string> unpinnedOpenApps: {
    const seen = new Set()
    for (const toplevel of Hyprland.toplevels.values) {
      const entry = HyprService.entryForClass(toplevel.lastIpcObject.class)
      if (entry && !cfg.pinnedApps.includes(entry.id)) {
        if (!cfg.blacklistedApps.includes(entry.id)) { 
          seen.add(entry.id)
        }
      }
    }
    return Array.from(seen)
  }

  Variants {
    model: Quickshell.screens

    // Trigger window: a thin strip on the bottom edge of the screen. It stays mapped at all times
    // so it can detect the pointer; the dock itself lives in a PopupWindow anchored to it.
    PanelWindow {
      id: panel
      anchors.bottom: true
      screen: modelData
      visible: cfg.monitors.includes('*') || cfg.monitors.includes(modelData.name)
      exclusiveZone: 0
      implicitHeight: cfg.triggerHeight
      implicitWidth: cfg.triggerWidth
      color: 'transparent'

    property var modelData
       property bool hoverRevealed: false

       readonly property int workspaceId: HyprService.getWorkspaceForScreen(panel.screen)
       readonly property bool workspaceIsBusy: HyprService.isWorkspaceTiled(workspaceId) || !HyprService.isWorkspaceFocused(workspaceId)
       readonly property bool hidden: cfg.dynamicHiding && (workspaceIsBusy && !hoverRevealed)
       readonly property bool hovered: dockMouse.containsMouse || triggerMouse.hovered

       // Mouse x coordinate mapped to the left edge of the default-scaled icon row
       property real contentRelativeMouseX: dockMouse.mouseX - shelf.x - iconRow.x
      
       property real zoomStrength: dockMouse.containsMouse ? 1 : 0
      
      onHoveredChanged: {
        if (!cfg.dynamicHiding) { return }  // Ignore the hover event if hiding is disabled
        if (hovered) {
          hoverRevealed = true
          hideTimer.stop()
        } else { 
          hideTimer.restart()
        }
      }
      
      HoverHandler { id: triggerMouse }

      Reveal {
        id: reveal
        active: !panel.hidden
        enter: cfg.revealMotion
      }     

      Timer {
        id: hideTimer
        interval: cfg.hideDelay
        onTriggered: hoverRevealed = false
      }    
    
      // Visual component of the trigger; only shown while the dock is hidden.
      Rectangle {
        id: triggerRect
        anchors.fill: parent
        visible: cfg.showTrigger
        radius: height
        color: Qt.alpha(cfg.triggerColor, alpha)
        
        property real alpha: reveal.progress <= 0 ? cfg.triggerAlpha : 0.0
        Ease on alpha { preset: Motion.fade }
      }

      PopupWindow {
        id: popup
        anchor {
          window: panel 
          edges: Edges.Bottom          
          gravity: Edges.Top
          adjustment: PopupAdjustment.None
          rect.x: 0
          rect.y: 0
          rect.width: panel.width
          rect.height: panel.height
        }
        // visible: panel.visible && panel.revealProgress > 0
        visible: panel.visible && reveal.shown
        implicitWidth: root.totalDockWidth 
        implicitHeight: cfg.height + cfg.bottomMargin + cfg.hoverZoneMargin
        color: 'transparent'

        // Everything that visually moves lives in here; the PopupWindow itself is static
        Item {
          width: parent.width
          height: parent.height
          y: (1 - reveal.progress) * root.displacement

          MouseArea {
            id: dockMouse
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.NoButton
          }

          Rectangle {
            id: shelf
            anchors {
              bottom: parent.bottom
              bottomMargin: cfg.bottomMargin
              horizontalCenter: parent.horizontalCenter
            }
            implicitWidth: iconRow.width + (2 * cfg.iconRowPadding)
            implicitHeight: cfg.height
            radius: cfg.radius
            color: Qt.alpha(cfg.bgColor, cfg.alpha)
            border.color: Qt.alpha(cfg.borderColor, cfg.alpha)
            antialiasing: true

            Row {
              id: iconRow
              anchors {
                left: parent.left
                leftMargin: cfg.iconRowPadding
                bottom: parent.bottom
                bottomMargin: cfg.iconRowPadding
              }

              Repeater {
                id: pinnedAppsRepeater
                model: cfg.pinnedApps

                DockIcon {
                  iconSize: root.iconSize
                  mouseX: panel.contentRelativeMouseX
                  zoomStrength: panel.zoomStrength
                }
              }

              Item {
                id: separatorLineContainer
                anchors.verticalCenter: parent.verticalCenter
                visible: root.showSeparatorLine 
                height: iconSize
                width: line.width < 1 ? 0 : line.width + (cfg.iconSpacing * 2)

                Rectangle {
                  id: line
                  anchors.centerIn: parent
                  height: parent.height * 0.75
                  width: cfg.separatorLineWidth
                  radius: width
                  color: Colors.outline
                }
              }

              Repeater {
                id: openAppsRepeater
                model: root.unpinnedOpenApps

                DockIcon {
                  iconSize: root.iconSize
                  mouseX: panel.contentRelativeMouseX
                  zoomStrength: panel.zoomStrength
                }
              }
            }
          }
        }
      }
    } 
  }
}

