import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import qs.Theme
import qs.Services
import qs.Components

Item {
  implicitWidth: content.implicitWidth 
  implicitHeight: content.implicitHeight

  Rectangle {
    anchors.fill: content
    anchors.margins: -5
    color: 'transparent'
    border.color: Colors.debug
  }
  
  RowLayout {
    id: content
    anchors.centerIn: parent
    spacing: 10

    Repeater {
      model: SystemTray.items.values

      Rectangle {
        implicitHeight: 16
        implicitWidth: 16
        color: 'transparent'
        border.color: Colors.debug

        MouseArea {
          anchors.fill: parent
          onClicked: console.log(modelData.id)
          cursorShape: Qt.PointingHandCursor
        }

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
