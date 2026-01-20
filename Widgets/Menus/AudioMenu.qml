import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.Pipewire

import qs
import qs.Theme
import qs.Services
import qs.Components


Scope {
  id: root
  
  required property var boundItem

  readonly property int blockRadius: 8
  readonly property int padding: 12

  property alias isVisible: menu.isVisible
  onIsVisibleChanged: GlobalStates.audioMenuOpen = isVisible

  ContextMenu {
    id: menu
    boundItem: root.boundItem

    // Title block
    Rectangle {
      width: parent.width
      height: titleRow.height * 2
      radius: root.blockRadius
      color: Colors.alpha(Colors.background, 0.75)


      RowLayout {
        id: titleRow
        width: parent.width
        anchors {
          left: parent.left
          right: parent.right
          margins: 10
          verticalCenter: parent.verticalCenter
        }

        WrapperMouseArea {
          id: muteButton
          hoverEnabled: true
          onClicked: AudioService.activeSink.audio.muted = !AudioService.activeSink.audio.muted

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
            text: '\uea03'//'\ueb55'
            color: mixerButton.containsMouse? Colors.secondary : Colors.foreground
            font: Fonts.menuHeadingIcon
            Behavior on color { ColorAnimation { duration: 100; easing.type: Easing.OutQuad } } 
          }
        }
      }
    }

    // Output slider block
    Rectangle {
      width: parent.width
      height: sinkSliderCol.height + (root.padding * 2.25)
      radius: root.blockRadius
      color:  Colors.alpha(Colors.background, 0.75) 

      Column { 
        id: sinkSliderCol
        anchors {
          left: parent.left
          right: parent.right
          top: parent.top
          margins: root.padding
        }
        spacing: 10

        Row {
          spacing: 8
          Text {
            id: sinkSliderLabel
            text: 'Output Volume'
            font: Fonts.menuSubheading
            color: Colors.primary
          }
          Text {
            anchors.baseline: sinkSliderLabel.baseline
            text: `(${AudioService.activeSink?.description})`
            font: Fonts.menuBody
            color: Colors.foreground
          }
        }
        
        Row {
          spacing: 8
          height: 10
          width: sinkSliderCol.width
          StyledSlider {
            anchors.verticalCenter: parent.verticalCenter
            width: sinkSliderCol.width - sinkVolumeLabel.width
            value: AudioService.volume
            onMoved: AudioService.setVolume(value)
          }
          Text {
            id: sinkVolumeLabel
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            horizontalAlignment: Text.AlignHCenter
            text: `${AudioService.volumeAsInt}%`
            font: Fonts.jetbrains
            color: Colors.foreground
          }
        }
      }

      // Handles scrolling but allows clicks to pass through
      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        onWheel: (event) => {
          let step = 0.02
          if (event.angleDelta.y > 0) AudioService.setVolume(AudioService.volume + step)
          if (event.angleDelta.y < 0) AudioService.setVolume(AudioService.volume - step)
        }
      }
    }

    // Output device list block
    Rectangle {
      width: parent.width
      height: sinkListCol.height + (root.padding * 2.25)
      radius: root.blockRadius
      color: Colors.alpha(Colors.background, 0.75)

      Column {
        id: sinkListCol
        anchors {
          left: parent.left
          right: parent.right
          top: parent.top
          margins: root.padding
        }
        spacing: 4

        Text {
          text: 'Output Devices'
          font: Fonts.menuSubheading
          color: Colors.primary
        }

        Repeater {
          model: AudioService.availableSinks

          WrapperMouseArea {
            hoverEnabled: true
            onClicked: AudioService.setPreferredSink(modelData)

            Row {
              id: sinkDeviceRow
              width: sinkListCol.width
              spacing: 6
           
              property color textColor: {
                if (parent.containsMouse) return Colors.secondary
                if (modelData.id == AudioService.activeSinkId) return Colors.foreground
                else return Colors.mOnSurfaceVariant
              }
              Behavior on textColor { ColorAnimation { duration: 100; easing.type: Easing.InOutQuad } }

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: AudioService.getSinkSymbol(modelData.description)
                font: Fonts.tabler
                color: parent.textColor
              }

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: modelData.description
                font: Fonts.menuBody
                color: parent.textColor
              }
            }
          }
        }
      }
    }
  }
}

