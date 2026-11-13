import QtQuick
import Quickshell
import qs
import qs.style
import qs.components

Item {
  id: root
  
  implicitWidth: iconSize + cfg.iconSpacing
  implicitHeight: iconSize + cfg.dotGap + cfg.dotSize
  transform: Translate { x: root.pushOffset }

  readonly property QtObject cfg: Config.dock
  
  // Provided by the parent Repeater
  required property string modelData  // DesktopEntry.id
  required property int index
  required property real mouseX 
  required property real zoomStrength
  required property real iconSize
  
  readonly property var entry: DockService.entryForId(modelData)
  readonly property int windowCount: DockService.windowCount(entry)
  
  readonly property alias cellSize: root.implicitWidth
  
  // Signed (+/-) distance from the pointer to this icon's layout center (positive = icon is right of the pointer)
  readonly property real pointerOffset: (root.x + root.width / 2) - mouseX

  property real zoom: {
    const radius = cfg.growthRadius * cellSize
    const distance = Math.abs(pointerOffset)
    const falloff = distance >= radius ? 0 : 0.5 * (1 + Math.cos(Math.PI * distance / radius))
    return 1 + (cfg.maxGrowth - 1) * falloff * zoomStrength    
  }
  Ease on zoom { preset: cfg.zoomMotion }

  // Shoves icon away from the pointer. Zero directly under the pointer, peaks at half of pushRadius,
  // and returns to zero at pushRadius, so only the nearest icons move and the rest of the row stays put.
  property real pushOffset: {
    const radius = cfg.pushRadius * cellSize
    if (Math.abs(pointerOffset) >= radius) return 0
    return cfg.pushDistance * Math.sin(Math.PI * pointerOffset / radius) * zoomStrength
  }
  Ease on pushOffset { preset: cfg.pushMotion }  

  Image {
    id: iconImage
    anchors {
      bottom: dots.top
      bottomMargin: cfg.dotGap
      horizontalCenter: parent.horizontalCenter
    }
    width: root.iconSize * root.zoom
    height: width
    source: Quickshell.iconPath(root.entry?.icon ?? '', cfg.fallbackIcon)
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
    height: cfg.dotSize
    spacing: cfg.dotSpacing

    Repeater {
      model: Math.min(root.windowCount, cfg.maxDots)
      
      Rectangle {
        width: cfg.dotSize
        height: width
        radius: width
        color: cfg.dotColor
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
    height: iconImage.height + cfg.dotGap + cfg.dotSize
    acceptedButtons: Qt.LeftButton
    cursorShape: Qt.PointingHandCursor
    onClicked: DockService.launch(root.entry)
  }
}

