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
  property alias font: label.font
  property alias iconSize: icon.font.pixelSize

  property alias mouseArea: ma
  
  // Colors and animations
  property color colorStd: Colors.mOnSurface
  property color colorOnHover: Colors.primary //Colors.mOnSurfaceVariant
  property color colorAnimated: ma.containsMouse ? root.colorOnHover : root.colorStd

  property alias animDuration: anim.duration
  
  Behavior on colorAnimated { ColorAnim { id: anim } }

  
  Rectangle {
    id: bgRect
    anchors.fill: parent
    radius: height
    color: Config.widget.pillColor
    // border.color: Colors.outline

    Row {
      id: container
      anchors.centerIn: parent
      layoutDirection: Qt.LeftToRight
      spacing: 2

      Text {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        font.family: Fonts.tabler.family
        font.pixelSize: Fonts.tabler.pixelSize
        color: root.colorAnimated
      }

      Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        font: Config.widget.textFont
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
    onClicked: root.clicked()
  }
  signal clicked()
}

