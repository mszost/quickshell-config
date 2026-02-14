import QtQuick
import QtQuick.Layouts

import Quickshell.Widgets

import qs.style


Item {
  property string text
  property string icon
  property var onIconClicked
  property string adjustmentsCmd
  
  property int radius
  height:


  Rectangle {
    id: bgRect
    width: parent.width
    height: row.height * 1.8
    radius: root.radius
    color: Colors.alpha(Colors.background, bgAlpha)


    RowLayout {
      id: row
      width: parent.width
      spacing: 8
      anchors {
        left: parent.left
        right: parent.right
        margins: 
        10
        verticalCenter: parent.verticalCenter
    }

      WrapperMouseArea {
        id: muteButton
        hoverEnabled: true
        // onClicked: AudioService.activeSink.audio.muted = !AudioService.activeSink.audio.muted

        Text {
          text: AudioService.symbol
          font: Fonts.menuHeadingIcon
          color: muteButton.containsMouse ? Colors.secondary : Colors.primary
          Behavior on color { ColorAnimation { duration: 100; easing.type: Easing.OutQuad } } 
        }
      }

      Text {
        text: 'Audio'
        font: Fonts.menuHeading
        color: Colors.foreground
      }

      // Spacer
      Item { Layout.fillWidth: true }

      // Click to open pavucontrol
      WrapperMouseArea {
        id: mixerButton
        Layout.preferredWidth: 24
        Layout.preferredHeight: 24
        hoverEnabled: true
        onClicked: {
          Hyprland.dispatch('exec pavucontrol')
          root.isVisible = false
        }

        Text { 
          text: Icons.tabler['adjustments']
          color: mixerButton.containsMouse? Colors.secondary : Colors.foreground
          font: Fonts.menuHeadingIcon
          Behavior on color { ColorAnimation { duration: 100; easing.type: Easing.OutQuad } } 
        }
      }
    }
  }

