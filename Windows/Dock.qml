import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

import qs
import qs.Theme
import qs.Services


Scope {
  id: root
  readonly property int offset: 6   // height offset from the bottom edge of the screen
  readonly property int buffer: 16  // used as padding for popup and bgRect
  readonly property list<string> dockMonitors: Config.dockMonitors 
  readonly property list<string> dockApps: Config.dockApps

  readonly property real bgAlpha: Config.dockAlpha ?? Config.alpha ?? 1.0

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      anchors.bottom: true
      implicitHeight: 0
      implicitWidth: bgRect.width 
      color: 'transparent'
      exclusiveZone: 0
      
      screen: modelData
      required property var modelData
      
      // All of the properties below must be chidren of panel so that their states are stored separately for each screen
      property bool dockIsVisible: { 
        if (!dockMonitors.includes(modelData.name)) return false
        if (!isFocused) return false
        if (!isOccupied) return true
        return isHovered
      }
      
      property bool isFocused: Hyprland.focusedMonitor?.name == modelData.name
      property bool isOccupied: HyprlandService.isWorkspaceOccupied(Hyprland.focusedWorkspace?.id)
      property bool isHovered: enterArea.hovered || exitArea.hovered

      // Hovering near the bottom edge of the screen triggers the dock to open
      HoverHandler { id: enterArea } 

      PopupWindow { 
        id: popup
        anchor {
          window: panel
          // center horizontally
          rect.x: panel.width/2 - width/2  
          adjustment: PopupAdjustment.None
          edges: Edges.Top | Edges.Center
          gravity: Edges.Top | Edges.Right
        }
        // popup is slightly larger than the visible bgRect in order 
        // to avoid clipping the animation and exitArea
        implicitWidth: bgRect.width + buffer 
        implicitHeight: bgRect.height + offset + buffer 
        visible: bgRect.y < height 
        color: 'transparent'

        Rectangle {
          id: bgRect
          anchors.horizontalCenter: parent.horizontalCenter
          height: 72
          width: content.width + buffer*2
          radius: height * 0.3
          color: Colors.alpha(Colors.background, bgAlpha)
          border.color: Colors.alpha(Colors.outlineVariant, bgAlpha)
          border.width: 1
          antialiasing: true
          
          // TODO: with the new HoverHandler implementation (replacing MouseArea)
          // the below expression for `y` can likely be simplified.
          
          // Sliding in/out animation
          y: panel.dockIsVisible ? (parent.height - height - offset) : parent.height
          Behavior on y { NumberAnimation { duration: 300; easing.type: Easing.OutBack } }

          // Leaving the bounds of bgRect dismisses the dock
          HoverHandler { id: exitArea; margin: buffer } 
          
          RowLayout {
            id: content
            anchors.centerIn: parent
            spacing: 8
            
            Repeater {
              model: root.dockApps
                             
              WrapperMouseArea {
                id: iconArea
                child: appIcon
                resizeChild: false
                Layout.preferredWidth: 55  // actual rendered pixel size, downscaled from appIcon.sourceSize
                Layout.preferredHeight: 55
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: { 
                  clickAnimation.restart()
                  DesktopEntries.byId(modelData).execute()
                }

                Image {
                  id: appIcon
                  anchors.fill: parent
                  // Wait for the full application list to load to prevent a race condition
                  source: (DesktopEntries.applications.values, DesktopEntries.byId(modelData)?.icon ?? '') 
                  sourceSize.width: 128
                  mipmap: true
                  scale: iconArea.containsMouse ? 1.15 : 1.0
                  visible: true
                 
                  Behavior on scale { NumberAnimation { 
                    duration: 100
                  }} 

                  SequentialAnimation on scale {
                    id: clickAnimation
                    running: false
                    NumberAnimation { to: 1.0; duration: 100 }
                    NumberAnimation { to: 1.15; duration: 100 }
                  }
                }

                // MultiEffect {  // drop shadow effect for each icon
                //   anchors.fill: parent
                //   source: appIcon
                //   shadowEnabled: true
                //   shadowBlur: 0
                //   shadowColor: "black"
                //   shadowVerticalOffset: 5
                //   shadowHorizontalOffset: 5
                // }
              }
            }
          }
        }
      }
    }
  }
}

