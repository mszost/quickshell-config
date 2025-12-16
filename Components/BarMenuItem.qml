// A reusable component for a single row in the menu. It handles its own hover state and clicking logic.

import QtQuick
import qs.Theme 

Rectangle {
  id: root
    
  property string text: ""
  signal clicked()

  width: parent.width
  height: 22 // Standard height for a row
  color: m.containsMouse ? Colors.foreground : "transparent"
  radius: 8

  Text {
    text: root.text
    font: Fonts.barText 
    color: m.containsMouse ? Colors.background : Colors.foreground
    
    anchors.fill: parent
    anchors.leftMargin: 5
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
    // Behavior on color {
    //   ColorAnimation {
    //     duration: 50
    //     easing.type: Easing.InOutQuad
    //   }
    // }
  }

    // Interaction
  MouseArea {
    id: m
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      root.clicked()
    }
  }

  // Behavior on color {
  //   ColorAnimation {
  //     duration: 50
  //     easing.type: Easing.InOutQuad
  //   }
  // }
}
