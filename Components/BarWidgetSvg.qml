// Top-bar item template for a text item and a SVG image side-by-side.

import QtQuick
import QtQuick.Layouts

import qs.Theme
import qs.Theme.Icons


Item {
  id: root

  // This stops the overlapping issue by telling the parent exactly how wide this widget is.
  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight


  // Text and icon
  property alias spacing: content.spacing
  property alias layoutDirection: content.layoutDirection
  
  property alias text: contentText.text
  default property alias icon: contentIcon.data 

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


  // Content
  RowLayout {
    id: content
    spacing: 1

    Text {
      id: contentText
      font.family: root.textFamily
      font.weight: root.textWeight
      font.pixelSize: root.textSize
      color: root.animatedColor
      Layout.alignment: Qt.AlignVCenter
    }
    Item {
      id: contentIcon
      Layout.alignment: Qt.AlignVCenter  
      implicitWidth: childrenRect.width
      implicitHeight: childrenRect.height
      // Optional: Bind properties to the loaded item if needed
      // binding { target: item; property: "color"; value: root.animatedColor }
    }  
  }
}

