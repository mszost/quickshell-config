import QtQuick
import Quickshell
import qs
import qs.style
import qs.components.common
import qs.modules.hyprland

Item {
  id: root
  
  implicitWidth: iconImage.width + Config.dock.iconSpacing
  implicitHeight: iconSize + Config.dock.dotGap + Config.dock.dotSize
  
  // Supplied by the Repeater / Dock
  required property string modelData // desktop file name, without extension
  // required property int index
  required property real iconSize
  // required property int hoveredIndex // -1 when the dock isn't hovered
  
  readonly property var entry: DesktopEntries.applications.values.find(e => e.id === modelData) ?? null
  readonly property int windowCount: HyprService.windowCountForApp(entry)

  Image {
    id: iconImage
    anchors {
      bottom: dots.top
      bottomMargin: Config.dock.dotGap
      horizontalCenter: parent.horizontalCenter
    }
    width: root.iconSize
    height: width
    source: Quickshell.iconPath(root.entry?.icon ?? '', Config.dock.fallbackIcon)
    sourceSize: Qt.size(root.iconSize, root.iconSize)
    fillMode: Image.PreserveAspectFit
    asynchronous: true
    mipmap: true
    smooth: true
  }

  Row {
    id: dots
    anchors {
      bottom: parent.bottom
      horizontalCenter: parent.horizontalCenter
    }
    height: Config.dock.dotSize
    spacing: Config.dock.dotSpacing

    Repeater {
      model: Math.min(root.windowCount, Config.dock.maxDots)
      
      Rectangle {
        width: Config.dock.dotSize
        height: width
        radius: width
        color: Config.dock.dotColor
      }
    }
  }
  
  // Click handler only; hover is tracked once for the whole dock in Dock.qml.
  MouseArea {
    anchors {
      left: parent.left
      right: parent.right
      bottom: parent.bottom
    }
    height: iconImage.height + Config.dock.dotGap + Config.dock.dotSize
    acceptedButtons: Qt.LeftButton
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      root.entry?.execute()
    }
  }
}

