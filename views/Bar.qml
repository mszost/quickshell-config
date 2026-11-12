import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs
import qs.style
import qs.components.common
import qs.components.bar
import qs.modules.hyprland
import qs.modules.core

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

      // Keyboard-interactive only while one of this screen's menus is open, so Escape can close it.
      // OnDemand, not Exclusive: an exclusive layer surface makes Hyprland clear the menu's focus grab.
      WlrLayershell.keyboardFocus: MenuService.isOpenOn(screen) ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

      margins {
        top: shouldFloat ? Config.bar.floatingMarginY : Config.bar.marginY
        bottom: shouldFloat ? Config.bar.floatingMarginY : Config.bar.marginY
        left: shouldFloat ? Config.bar.floatingMarginX : Config.bar.marginX
        right: shouldFloat ? Config.bar.floatingMarginX : Config.bar.marginX
      }
      
      property var modelData

      property bool shouldFloat: BarService.shouldFloat(screen)

      Ease on margins.top { preset: Motion.standard }
      Ease on margins.left { preset: Motion.standard }
      Ease on margins.right { preset: Motion.standard }


      Rectangle {
        id: bgRect
        anchors { fill: parent }
        antialiasing: true
        radius: panel.shouldFloat ? Config.bar.floatingRadius : Config.bar.radius
        color: BarService.bgColor(panel.screen)
        border.color: panel.shouldFloat ? Qt.alpha(Colors.outline, Config.bar.alpha) : 'transparent'
        focus: true

        Keys.onEscapePressed: MenuService.closeActive()

        Ease on radius { preset: Motion.standard }
        Ease on color { preset: Motion.standard }

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

