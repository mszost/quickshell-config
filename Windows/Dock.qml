import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

import qs.Theme
import qs.Services


Scope {
  id: root
  readonly property int offset: 6   // height offset from the bottom edge of the screen
  readonly property int buffer: 16  // used as padding for popup and DockRect
  readonly property list<string> dockApps: [
     'kitty',
     'org.gnome.Nautilus',
     'firefox',
     'vivaldi-stable',
     'obsidian',
     'code-oss',
     'vesktop',
     'steam',
     'org.keepassxc.KeePassXC',
  ]
  
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      anchors.bottom: true
      implicitHeight: 0
      implicitWidth: dockRect.width 
      color: 'transparent'
      exclusiveZone: 0
      screen: modelData
      
      required property var modelData

      property bool dockIsVisible: {  // Must be a child of panel so that the state is not shared between screens.
        if (!isFocused) return false
        if (!isOccupied) return true
        return isHovered
      }
      
      property bool isHovered: enterArea.hovered || exitArea.hovered
      property bool isFocused: Hyprland.focusedMonitor?.name == modelData?.name
      property bool isOccupied: HyprlandService.isWorkspaceOccupied(Hyprland.focusedWorkspace.id)

      // TODO: this block may be unnecessary, find a way to optimize without errors/warnings 
      property var monitor: {  // find the monitor that matches the current screen's name
        var monitors = HyprlandService.monitors
        for (let i=0; i<monitors.length; i++) {
          if (monitors[i].name == modelData.name) {
            return monitors[i].name
          }
        }
      }
      
      HoverHandler { id: enterArea }  // triggers the dock to open

      PopupWindow { 
        id: popup
        anchor {
          window: panel
          rect.x: panel.width/2 - width/2  // center horizontally
          adjustment: PopupAdjustment.None
          edges: Edges.Top | Edges.Center
          gravity: Edges.Top | Edges.Right
        }
        // popup is slightly larger than the visible dockRect
        // in order to avoid clipping exitArea
        implicitWidth: dockRect.width + buffer 
        implicitHeight: dockRect.height + offset + buffer 
        visible: dockRect.y <= height 
        color: 'transparent'

        // Visual component of the dock
        Rectangle {
          id: dockRect
          anchors.horizontalCenter: parent.horizontalCenter
          width: content.width + buffer*2
          height: 72
          radius: height * 0.3
          color: Colors.applyAlpha(Colors.background, 0.4)
          border.color: Colors.applyAlpha(Colors.foreground, 0.1)
          border.width: 1
          antialiasing: true
          
          // Sliding in/out animation
          // This expression for `y` allows the height of the PopupWindow (and thus the MouseArea 
          // which fills it) to be slightly taller than the maximum point which the dock slides up to.
          y: panel.dockIsVisible ? (parent.height - height - offset) : parent.height
          Behavior on y { NumberAnimation { duration: 350; easing.type: Easing.OutBack } }

          HoverHandler { id: exitArea; margin: buffer } // triggers the dock to close
          
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
                onClicked: DesktopEntries.byId(modelData).execute() // TODO: additional animation on click 

                Image {
                  id: appIcon
                  anchors.fill: parent
                  source: (DesktopEntries.applications.values, DesktopEntries.byId(modelData)?.icon ?? '')  // prevents a race condition
                  sourceSize.width: 128
                  mipmap: true
                  scale: iconArea.containsMouse ? 1.15 : 1.0
                  Behavior on scale { NumberAnimation { duration: 100 } }  
                  visible: true
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

