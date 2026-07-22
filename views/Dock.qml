import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import qs
import qs.style
import qs.components.dock
import qs.modules.hyprland

Scope {
  id: root
  readonly property int padY: Config.dockVerticalOffset
  readonly property int buffer: 8  // used as padding for popup and bgRect
  readonly property real bgAlpha: Config.dockAlpha ?? Config.alpha ?? 1.0

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      anchors.bottom: true
      implicitHeight: 0
      implicitWidth: 500//bgRect.width 
      // color: dockIsVisible ? 'transparent' : 'red'
      color: 'transparent'
      exclusiveZone: 0
      
      screen: modelData
      required property var modelData

      // All of the properties below must be chidren of panel so that their states are stored separately for each screen
      property bool dockIsVisible: { 
        if (!Config.dockMonitors.includes(modelData.name)) return false
        if (!isFocused) return false
        if (!isOccupied) return true
        return isHovered
      }
      
      readonly property bool isFocused: Hyprland.focusedMonitor?.name == modelData.name
      readonly property bool isOccupied: HyprService.isWsTiled(HyprService.getWsForScreen(modelData))
      readonly property bool isHovered: enterArea.hovered || exitArea.hovered

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
        implicitHeight: bgRect.height + padY + buffer 
        visible: bgRect.y < height 
        color: 'transparent'

        Rectangle {
          id: bgRect
          anchors.horizontalCenter: parent.horizontalCenter
          height: 64
          width: content.width + buffer*3.25
          radius: height * 0.3
          color: Colors.alpha(Config.dockColorBg, bgAlpha)
          border.color: Colors.alpha(Colors.outlineVariant, 0.5)
          border.width: 1
          antialiasing: true
          
          // TODO: with the new HoverHandler implementation (replacing MouseArea)
          // the below expression for `y` can likely be simplified.
          
          // Sliding in/out animation
          y: panel.dockIsVisible ? (parent.height - height - padY) : parent.height
          Behavior on y { NumberAnimation { duration: 220; easing.type: Easing.InOutCirc } }

          // Leaving the bounds of bgRect dismisses the dock
          HoverHandler { id: exitArea; margin: buffer } 
          
          RowLayout {
            id: content
            anchors.centerIn: parent
            spacing: 6
            
            Repeater {
              model: Config.dockApps
                             
              WrapperMouseArea {
                id: iconArea
                anchors.margins: -6
                child: appIcon
                resizeChild: false
                Layout.preferredWidth: 41  // Actual displayed resolution, downscaled from appIcon.sourceSize 
                Layout.preferredHeight: 41
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onPressed: (mouse) => {
                  if (mouse.button === Qt.LeftButton) {
                    clickAnimation.restart()
                  }
                }
                onClicked: { 
                  DesktopEntries.byId(modelData).execute()
                }

                Image {
                  id: appIcon
                  anchors.fill: parent
                  // Wait for the full application list to load (prevents a race condition)
                  source: (DesktopEntries.applications.values, DesktopEntries.byId(modelData)?.icon ?? '') 
                  sourceSize.width: 128  // Render resolution
                  mipmap: true
                  scale: iconArea.containsMouse ? 1.125 : 1.0
                  visible: true

                  // Hover animation 
                  Behavior on scale { NumberAnimation { 
                    duration: 200
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.3
                  }} 

                  // Click animation
                  SequentialAnimation on scale {
                    id: clickAnimation
                    running: false
                    NumberAnimation { to: 0.90; duration: 70 }
                    NumberAnimation { to: 1.10; duration: 70 }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

