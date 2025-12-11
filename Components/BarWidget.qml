// Top-bar item template for a single Text object. 

import QtQuick
import QtQuick.Layouts
import qs.Theme

Item {
  id: root

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight

  property alias text: content.text

  // Color logic
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


  // Content layout
  Text {
    id: content
    anchors.centerIn: parent
    font: Fonts.barText
    color: root.animatedColor
    }
}
