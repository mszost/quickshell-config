import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs
import qs.style
import qs.components
import qs.modules.hyprland
import qs.views.menu

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      anchors { top: true; left: true; right: true }
      screen: modelData
      visible: Config.bar.monitors.includes('*') || Config.bar.monitors.includes(modelData.name) 
      // Fixed size, tall enough for either margin set. The float transition animates bgRect inside
      // the window rather than the layer-shell margins, which would resize the surface every frame
      // and stall every animation in the bar while Hyprland reconfigures it.
      implicitHeight: Config.bar.height + 2 * Math.max(Config.bar.marginY, Config.bar.floatingMarginY)
      exclusiveZone: Config.bar.height + 2 * (shouldFloat ? Config.bar.floatingMarginY : Config.bar.marginY)
      mask: Region { item: bgRect }
      color: 'transparent'

      // Keyboard-interactive only while one of this screen's menus is open, so Escape can close it.
      // OnDemand, not Exclusive: an exclusive layer surface makes Hyprland clear the menu's focus grab.
      WlrLayershell.keyboardFocus: MenuService.isOpenOn(screen) ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

      property var modelData

      readonly property bool shouldFloat: BarService.shouldFloat(screen)

      Rectangle {
        id: bgRect
        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
          topMargin: panel.shouldFloat ? Config.bar.floatingMarginY : Config.bar.marginY
          leftMargin: panel.shouldFloat ? Config.bar.floatingMarginX : Config.bar.marginX
          rightMargin: panel.shouldFloat ? Config.bar.floatingMarginX : Config.bar.marginX
        }
        height: Config.bar.height
        antialiasing: true
        radius: panel.shouldFloat ? Config.bar.floatingRadius : Config.bar.radius
        color: BarService.bgColor(panel.screen)
        border.color: panel.shouldFloat ? Qt.alpha(Colors.outline, Config.bar.alpha) : 'transparent'
        focus: true

        Keys.onEscapePressed: MenuService.closeActive()

        Ease on anchors.topMargin { preset: Motion.standard }
        Ease on anchors.leftMargin { preset: Motion.standard }
        Ease on anchors.rightMargin { preset: Motion.standard }
        Ease on radius { preset: Motion.standard }
        Ease on color { preset: Motion.standard }

        WidgetContainer {
          anchors.centerIn: parent  
          widgets: Config.bar.widgetsCenter
        }

        RowLayout {
          anchors { 
            fill: parent
            leftMargin: Config.bar.widgetMarginsX
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

