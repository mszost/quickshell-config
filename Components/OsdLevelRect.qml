import QtQuick
import Quickshell
import qs.Theme


Rectangle {
  required property real level

  anchors { 
    left: parent.left
    top: parent.top
    bottom: parent.bottom 
  }
  width: Math.min(parent.width, (parent.width * root.level))
  radius: parent.radius
  color: Colors.foreground
    
  Behavior on width { 
    NumberAnimation { duration: 300; easing.type: Easing.OutBack; }
  }  
}
