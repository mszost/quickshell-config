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

  readonly property list<string> dockMonitors: [  // list of displays that the dock should appear on
    'eDP-2',
    'DP-10',
    'HDMI-1'
  ]

  readonly property list<string> dockApps: [ // names of .desktop files
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
      
      // All of the properties below must be chidren of panel so that their states are stored separately for each screen
      property bool dockIsVisible: { 
        if (!isFocused) return false
        if (!isOccupied) return true
        if (dockMonitors.includes(modelData.name)) return isHovered
        else return false
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
        // popup is slightly larger than the visible dockRect in order to avoid clipping the padded exitArea
        implicitWidth: dockRect.width + buffer 
        implicitHeight: dockRect.height + offset + buffer 
        visible: dockRect.y < height 
        color: 'transparent'

        Rectangle {
          id: dockRect
          anchors.horizontalCenter: parent.horizontalCenter
          height: 72
          width: content.width + buffer*2
          radius: height * 0.3
          color: Colors.alpha(Colors.background, 0.4)
          // border.color: Colors.alpha(Colors.foreground, 0.1)
          border.color: Colors.outlineVariant
          border.width: 1
          antialiasing: true
          
          // TODO: with the new HoverHandler implementation (replacing MouseArea)
          // the below expression for `y` can likely be simplified.
          
          // Sliding in/out animation
          y: panel.dockIsVisible ? (parent.height - height - offset) : parent.height
          Behavior on y { NumberAnimation { duration: 350; easing.type: Easing.OutBack } }

          // Leaving the bounds of dockRect dismisses the dock
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
                onClicked: DesktopEntries.byId(modelData).execute() // TODO: additional animation on click 

                Image {
                  id: appIcon
                  anchors.fill: parent
                  // Wait for the full application list to load to prevent a race condition
                  source: (DesktopEntries.applications.values, DesktopEntries.byId(modelData)?.icon ?? '') 
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

