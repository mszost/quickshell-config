// Template for a Widget in the bar containing two Text items side-by-side (an icon and a label)
// See Widgets/Bar/

import QtQuick
import qs.style

Item {
  id: root

  implicitWidth: content.implicitWidth 
  implicitHeight: content.implicitHeight

  readonly property var widgetContainerPos: parent.position
 
  // RowLayout
  property alias spacing: content.spacing
  property alias layoutDirection: content.layoutDirection

  // Text items (label and icon)
  property alias text: label.text
  property alias textFamily: label.font.family 
  property alias textSize: label.font.pixelSize
  property alias textWeight: label.font.weight

  property alias icon: icon.text
  property alias iconFamily: icon.font.family
  property alias iconSize: icon.font.pixelSize
  property alias iconWeight: icon.font.weight

  // Mouse
  property alias mouseArea: ma
  signal clicked()

  // Colors and animations
  property color normalColor: Colors.foreground
  property color hoverColor: Colors.primary //Colors.mOnSurfaceVariant
  property color animatedColor: ma.containsMouse ? root.hoverColor : root.normalColor

  property alias animDuration: anim.duration
  
  Behavior on animatedColor {
    ColorAnimation {
      id: anim
      duration: 100
      easing.type: Easing.InOutQuad
    }
  }

  // Rectangle {
  //   id: bgRect
  //   anchors.fill: parent
  //   anchors.margins: -2
  //   color: Colors.alpha(Colors.debug, 0.33)
  //   radius: height/4
  // }

  Row {
    id: content
    anchors.centerIn: parent
    layoutDirection: Qt.LeftToRight 
    spacing: 1

    Text {
      id: label
      anchors.verticalCenter: parent.verticalCenter
      font.family: Fonts.barLabel.family
      font.pixelSize: Fonts.barLabel.pixelSize
      font.weight: Fonts.barLabel.weight
      color: root.animatedColor
    }
          
    Text {
      id: icon
      anchors.verticalCenter: parent.verticalCenter
      anchors.verticalCenterOffset: -1
      font.family: Fonts.barIcon.family
      font.pixelSize: Fonts.barIcon.pixelSize
      font.weight: Fonts.barIcon.weight 
      color: root.animatedColor
    }
  }

  MouseArea {
    id: ma
    anchors.fill: parent
    anchors.margins: -8 
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clicked()
  }
}

