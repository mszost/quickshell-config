import QtQuick
import QtQuick.Layouts
import Quickshell
import qs
import qs.style
import qs.components.common
import qs.components.bar
import qs.modules.hyprland
import qs.modules.core

Scope {
  id: root

  readonly property QtObject cfg: Config.bar

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      anchors { top: true; left: true; right: true }
      screen: modelData
      visible: cfg.monitors.includes('*') || cfg.monitors.includes(modelData.name) 
      implicitHeight: cfg.height
      color: 'transparent'

      margins {
        top: shouldFloat ? cfg.floatingMarginY : cfg.marginY
        bottom: shouldFloat ? cfg.floatingMarginY : cfg.marginY
        left: shouldFloat ? cfg.floatingMarginX : cfg.marginX
        right: shouldFloat ? cfg.floatingMarginX : cfg.marginX
      }
      
      property var modelData

      property bool shouldFloat: BarService.shouldFloat(screen)

      // Behavior on margins.top { Anim { duration: shouldFloat ? Motion.veryFast : Motion.fast } }
      // Behavior on margins.left { Anim { duration: shouldFloat ? Motion.fast : Motion.fast } }
      // Behavior on margins.right { Anim { duration: shouldFloat ? Motion.fast : Motion.fast } }

      Ease on margins.top { preset: targetValue === cfg.floatingMarginY ? Motion.standard : Motion.standard }
      Ease on margins.left { preset: Motion.standard }
      Ease on margins.right { preset: Motion.standard }


      Rectangle {
        id: bgRect
        anchors { fill: parent }
        antialiasing: true
        radius: panel.shouldFloat ? cfg.floatingRadius : cfg.radius
        color: BarService.bgColor(panel.screen)
        border.color: panel.shouldFloat ? Qt.alpha(Colors.outline, cfg.alpha) : 'transparent'

        // Behavior on radius { Anim { duration: shouldFloat ? Motion.verySlow : Motion.veryFast } }
        // Behavior on color { ColorAnim { duration: Motion.veryFast } }
        Ease on radius { preset: targetValue === cfg.floatingRadius ? Motion.standard : Motion.standard }
        Ease on color { preset: Motion.standard }

        WidgetContainer {
          anchors.centerIn: parent  
          widgets: cfg.widgetsCenter
        }

        RowLayout {
          anchors { 
            fill: parent;
            leftMargin: cfg.widgetMarginsX;
            rightMargin: cfg.widgetMarginsX 
          }

          WidgetContainer {
            Layout.alignment: Qt.AlignLeft
            widgets: cfg.widgetsLeft
          }

          WidgetContainer {
            Layout.alignment: Qt.AlignRight
            widgets: cfg.widgetsRight 
          }
        }
      }
    }
  }
}

