import QtQuick
import QtQuick.Layouts
import Quickshell
import qs
import qs.style
import qs.components.common
import qs.components.bar
import qs.modules.hyprland

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      anchors { top: true; left: true; right: true }
      screen: modelData
      visible: Config.bar.monitors.includes('*') || Config.bar.monitors.includes(modelData.name) 
      implicitHeight: Config.bar.height
      color: 'transparent'

      margins {
        top: shouldFloat ? Config.bar.floatingMarginY : Config.bar.marginY
        left: shouldFloat ? Config.bar.floatingMarginX : Config.bar.marginX
        right: shouldFloat ? Config.bar.floatingMarginX : Config.bar.marginX
      }
      
      property var modelData

      property bool shouldFloat: Config.bar.dynamicFloating && 
        !HyprService.isWorkspaceTiled(HyprService.getWorkspaceForScreen(panel.screen))

      Behavior on margins.top { Anim { duration: shouldFloat ? Motion.veryFast : Motion.fast } }
      Behavior on margins.left { Anim { duration: shouldFloat ? Motion.fast : Motion.fast } }
      Behavior on margins.right { Anim { duration: shouldFloat ? Motion.fast : Motion.fast } }

      Rectangle {
        id: bgRect
        anchors { fill: parent }
        antialiasing: true
        radius: panel.shouldFloat ? Config.bar.floatingRadius : Config.bar.radius
        color: Qt.alpha(Config.bar.color, panel.shouldFloat ? Config.bar.floatingAlpha : Config.bar.alpha)
        border.color: panel.shouldFloat ? Qt.alpha(Colors.outline, Config.bar.alpha) : 'transparent'

        Behavior on radius { Anim { duration: shouldFloat ? Motion.verySlow : Motion.veryFast } }
        Behavior on color { ColorAnim { duration: Motion.veryFast } }

        WidgetContainer {
          anchors.centerIn: parent  
          widgets: Config.bar.widgetsCenter
        }

        RowLayout {
          anchors { 
            fill: parent;
            leftMargin: Config.bar.widgetMarginsX;
            rightMargin: Config.bar.widgetMarginsX 
          }

          WidgetContainer {
            Layout.alignment: Qt.AlignLeft
            widgets: Config.bar.widgetsLeft
          }

          WidgetContainer {
            Layout.alignment: Qt.AlignRight
            widgets: Config.bar.widgetsRight 
          }
        }
      }
    }
  }
}

