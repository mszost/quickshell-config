import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import Quickshell.Services.StatusNotifier
import qs.style

Item {
  id: root
  implicitWidth: content.implicitWidth 
  implicitHeight: content.implicitHeight

  Rectangle {
    anchors.fill: content
    anchors.margins: -4
    color: 'transparent'
    border.color: Colors.debug
  }
  
  RowLayout {
    id: content
    anchors.centerIn: parent
    spacing: 10

    Repeater {
      model: SystemTray.items

      Rectangle {
        id: itemRect
        required property StatusNotifierItem modelData
        // implicitHeight: 16
        // implicitWidth: 16
        color: 'transparent'
        border.color: Colors.debug

        // MouseArea {
        //   anchors.fill: parent
        //   acceptedButtons: Qt.LeftButton | Qt.RightButton
        //   cursorShape: Qt.PointingHandCursor
        //   onClicked: {
        //     if (mouse.button === Qt.RightButton) modelData.display(itemRect)
        //     if (mouse.button === Qt.LeftButton) modelData.activate()
        //   }
        // }

        Image {
          id: iconImage
          anchors.fill: parent
          source: modelData.icon
          sourceSize.width: 128
          sourceSize.height: 128
          mipmap: true
        }
      }
    }
  }
}

