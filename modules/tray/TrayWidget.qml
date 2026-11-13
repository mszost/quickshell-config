// One pill holding an icon per tray item. Each icon owns a TrayMenu exposing that app's own menu.

import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs
import qs.style
import qs.components.common

Rectangle {
  id: root
  visible: TrayService.items.length > 0
  implicitHeight: Config.widget.pillHeight
  implicitWidth: iconRow.width + Config.widget.pillPaddingX
  radius: height
  color: Qt.alpha(Config.widget.pillColor, Config.widget.pillAlpha)

  readonly property QtObject cfg: Config.module.tray

  Row {
    id: iconRow
    anchors.centerIn: parent
    height: parent.height
    spacing: cfg.iconSpacing

    Repeater {
      model: TrayService.items

      // Full pill height, so the menu attaches to the bar exactly like it does for regular Widgets.
      MouseArea {
        id: trayIcon
        implicitWidth: cfg.iconSize
        implicitHeight: parent.height
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

        required property SystemTrayItem modelData

        onClicked: (mouse) => TrayService.handleClick(modelData, mouse.button, menu)
        onWheel: (wheelEvent) => TrayService.scroll(modelData, wheelEvent)

        TrayMenu {
          id: menu
          boundWidget: trayIcon
          trayItem: trayIcon.modelData
        }

        IconImage {
          anchors.centerIn: parent
          implicitSize: cfg.iconSize
          source: TrayService.iconSource(trayIcon.modelData)
          opacity: trayIcon.containsMouse || menu.open ? cfg.iconHoverAlpha : 1

          Ease on opacity {}
        }
      }
    }
  }
}
