import QtQuick
import qs
import qs.style
import qs.components.common

Item {
  id: root

  // Pill is a circle when the widget has no label. 
  implicitHeight: Config.widget.pillHeight
  implicitWidth: hasLabel ? container.width + Config.widget.pillPaddingX : height

  readonly property bool hasLabel: label.text !== ''
  // readonly property bool hasIcon: icon.text !== ''

  property alias layoutDirection: container.layoutDirection
  property alias spacing: container.spacing
  
  property alias text: label.text
  property alias icon: icon.text

  property alias textColor: label.color
  property alias iconColor: icon.color
  property font font: Config.widget.textFont
  property font iconFont: Config.widget.iconFont

  property alias mouseArea: ma

  // Optional MenuWindow, toggled by clicking the widget.
  property QtObject menu: null

  // Scrolling over the widget emits `scrolled` with ±scrollStep. Disabled while 0.
  property real scrollStep: 0

  // Colors and animations
  property color colorStd: Colors.mOnSurface
  property color colorOnHover: Colors.primary //Colors.mOnSurfaceVariant
  property color colorAnimated: (ma.containsMouse || root.menu?.open) ? root.colorOnHover : root.colorStd

  property var motion: Motion.standard
  Ease on colorAnimated { preset: root.motion }

  
  Rectangle {
    id: bgRect
    anchors.fill: parent
    radius: height
    color: Qt.alpha(Config.widget.pillColor, Config.widget.pillAlpha)
    // border.color: Colors.outline

    Row {
      id: container
      anchors.centerIn: parent
      layoutDirection: Qt.LeftToRight
      spacing: Config.widget.iconSpacing

      Text {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        font: root.iconFont
        color: root.colorAnimated
      }

      Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        font: root.font
        color: root.colorAnimated
      }
    }
  }
  
  MouseArea {
    id: ma
    anchors.fill: parent
    // anchors.margins: -8 
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      root.menu?.toggle()
      root.clicked()
    }
    onWheel: (wheelEvent) => {
      const dy = wheelEvent.angleDelta.y
      if (root.scrollStep === 0 || dy === 0) {
        wheelEvent.accepted = false
        return
      }
      root.scrolled(dy > 0 ? root.scrollStep : -root.scrollStep)
    }
  }

  signal clicked()
  signal scrolled(real delta)
}

