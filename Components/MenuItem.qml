// A reusable component for a single row in the menu. It handles its own hover state and clicking logic.

import QtQuick
import QtQuick.Layouts
import qs.Theme 


Rectangle {
  id: root
    
  property string text: ""
  property int rowHeight: parent.rowHeight  // parent is the ColumnLayout in Menu.qml
  property color textColor: Colors.foreground
  property color textHoverColor: Colors.background

  property color bgColor: "transparent"
  property color bgHoverColor: Colors.foreground // background Rectangle color on hover
  
  property string textFamily: Fonts.barText.family
  property int textSize: Fonts.barText.pixelSize
  property int textWeight: Fonts.barText.weight
  
  signal clicked()

  width: parent.width * 0.9
  Layout.alignment: Qt.AlignHCenter
  height: rowHeight 
  color: m.containsMouse ? bgHoverColor : bgColor
  radius: 6

  Behavior on color {
    ColorAnimation { duration: 100; easing.type: Easing.InOutQuad }
  }

  Text {
    text: root.text
    font: Qt.font({
      family: textFamily,
      pixelSize: textSize,
      weight: textWeight
    })
    color: m.containsMouse ? textHoverColor : textColor
    anchors.centerIn: parent
    width: parent.width -20
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight

    Behavior on color {
      ColorAnimation { duration: 100; easing.type: Easing.InOutQuad }
    }
  }

  MouseArea {
    id: m
    anchors.fill: parent
    anchors.margins: -4
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      root.clicked()
    }
  }
}

