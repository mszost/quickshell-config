// This component is the same as the regular BarWidget, except it only has one Text Item
// instead of two Text items in a RowLayout. 

import QtQuick
import QtQuick.Layouts

import qs.Theme


Item {
  id: root

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight
  
  property alias text: content.text

  property string textFamily: Fonts.barText.family
  property int textSize: Fonts.barText.pixelSize
  property int textWeight: Fonts.barText.weight

  // Color
  property color normalColor: Colors.foreground
  property color hoverColor: Colors.applyAlpha(Colors.foreground, 0.5)
  property color animatedColor: m.containsMouse ? root.hoverColor : root.normalColor

  Behavior on animatedColor {
    ColorAnimation {
      id: anim
      duration: defaultDuration
      easing.type: Easing.InOutQuad
    }
  }
  property int defaultDuration: 150
  property alias animationSpeed: anim.duration

  // Mouse hitbox
  property alias mouseArea: m
  property alias containsMouse: m.containsMouse
  signal clicked()

  MouseArea {
    id: m
    anchors.fill: parent
    anchors.margins: -8 
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clicked()
  }

  Text {
    id: content
    font.family: root.textFamily
    font.weight: root.textWeight
    font.pixelSize: root.textSize
    color: root.animatedColor
    Layout.alignment: Qt.AlignVCenter
  }
}

