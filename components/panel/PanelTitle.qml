import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.style

PanelRow {
  id: root
  verticalPadding: 10
  // height: content.height * 1.8

  required property string text
  required property string icon

  property alias adjustBtn: adjustBtn
  property alias serviceBtn: serviceBtn


  RowLayout {
    id: content
    implicitWidth: parent.width
    spacing: 8

    WrapperMouseArea {
      id: serviceBtn
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
      
      Text {
        text: root.icon
        font: Fonts.menuHeadingIcon
        color: parent.containsMouse ? Colors.secondary : Colors.primary 
        Behavior on color { ColorAnimation { duration: 100; easing.type: Easing.InOutQuad } } 
      }
    }

    Text {
      Layout.fillWidth: true
      text: root.text
      font: Fonts.menuHeading
      color: Colors.foreground
    }

    WrapperMouseArea {
      id: adjustBtn
      visible: true
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
      
      Text {
        text: Icons.adjustments
        font: Fonts.menuHeadingIcon
        color: parent.containsMouse ? Colors.secondary : Colors.foreground
        Behavior on color { ColorAnimation { duration: 100; easing.type: Easing.InOutQuad } } 
      }
    }
  }
}
