import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.Pipewire

import qs
import qs.style
import qs.templates
import qs.components.bar
import qs.components.common

Scope {
  id: root
  
  required property var boundItem
  required property var widgetContainerPos

  readonly property int blockRadius: 12
  readonly property int padding: 12

  property alias isVisible: menu.isVisible
  onIsVisibleChanged: GlobalStates.menuAudioIsOpen = isVisible

  property real bgAlpha: Config.menuRowAlpha ?? Config.alpha ?? 1.0

  Panel {
    id: menu
    boundItem: root.boundItem
    widgetContainerPos: root.widgetContainerPos

    // Title block
    Rectangle {
      width: parent.width
      height: titleRow.height * 1.8
      radius: root.blockRadius
      color: Colors.alpha(Colors.background, bgAlpha)


      RowLayout {
        id: titleRow
        width: parent.width
        spacing: 8
        anchors {
          left: parent.left
          right: parent.right
          margins: 10
          verticalCenter: parent.verticalCenter
      }

        WrapperMouseArea {
          id: muteButton
          hoverEnabled: true
          onClicked: BacklightService.toggleFilter()

          Text {
            text: BacklightService.symbol
            font: Fonts.menuHeadingIcon
            color: muteButton.containsMouse ? Colors.secondary : Colors.primary
            Behavior on color { ColorAnimation { duration: 100; easing.type: Easing.OutQuad } } 
          }
        }

        Text {
          text: 'Brightness'
          font: Fonts.menuHeading
          color: Colors.foreground
        }

        // Spacer
        Item { Layout.fillWidth: true }

        // Click to open pavucontrol
        // WrapperMouseArea {
        //   id: mixerButton
        //   Layout.preferredWidth: 24
        //   Layout.preferredHeight: 24
        //   hoverEnabled: true
        //   onClicked: {
        //     Hyprland.dispatch('exec pavucontrol')
        //     root.isVisible = false
        //   }
        //
        //   Text { 
        //     text: Icons.tabler['adjustments']
        //     color: mixerButton.containsMouse? Colors.secondary : Colors.foreground
        //     font: Fonts.menuHeadingIcon
        //     Behavior on color { ColorAnimation { duration: 100; easing.type: Easing.OutQuad } } 
        //   }
        // }
      }
    }

    // Output slider block
    Rectangle {
      width: parent.width
      height: sinkSliderCol.height + (root.padding * 2.25)
      radius: root.blockRadius
      color:  Colors.alpha(Colors.background, bgAlpha) 

      Column { 
        id: sinkSliderCol
        anchors {
          left: parent.left
          right: parent.right
          top: parent.top
          margins: root.padding
        }
        spacing: 10

        Text {
          id: sinkSliderLabel
          text: 'eDP-2'
          font: Fonts.menuSubheading
          color: Colors.primary
        }
        
        Row {
          spacing: 8
          height: 10
          width: sinkSliderCol.width

          StyledSlider {
            anchors.verticalCenter: parent.verticalCenter
            width: sinkSliderCol.width - sinkVolumeLabel.width
            value: BacklightService.percentage / 100
            onMoved: BacklightService.setBrightness(value * 100)
          }

          Text {
            id: sinkVolumeLabel
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            horizontalAlignment: Text.AlignHCenter
            text: `${BacklightService.percentage}%`
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
          let step = 2
          if (event.angleDelta.y > 0) BacklightService.setBrightness(BacklightService.percentage + step)
          if (event.angleDelta.y < 0) BacklightService.setBrightness(BacklightService.percentage - step)
        }
      }
    }

    // Output device list block
    // Rectangle {
    //   width: parent.width
    //   height: sinkListCol.height + (root.padding * 2.25)
    //   radius: root.blockRadius
    //   color: Colors.alpha(Colors.background, bgAlpha)
    //
    //   Column {
    //     id: sinkListCol
    //     anchors {
    //       left: parent.left
    //       right: parent.right
    //       top: parent.top
    //       margins: root.padding
    //     }
    //     spacing: 4
    //
    //     Text {
    //       text: 'Output Devices'
    //       font: Fonts.menuSubheading
    //       color: Colors.primary
    //     }
    //
    //     Repeater {
    //       model: AudioService.availableSinks
    //
    //       WrapperMouseArea {
    //         hoverEnabled: true
    //         onClicked: AudioService.setPreferredSink(modelData)
    //
    //         Row {
    //           id: sinkDeviceRow
    //           width: sinkListCol.width
    //           spacing: 6
    //
    //           property color textColor: {
    //             if (parent.containsMouse) return Colors.secondary
    //             if (modelData.id == AudioService.activeSinkId) return Colors.foreground
    //             else return Colors.mOnSurfaceVariant
    //           }
    //           Behavior on textColor { ColorAnimation { duration: 100; easing.type: Easing.InOutQuad } }
    //
    //           Text {
    //             anchors.verticalCenter: parent.verticalCenter
    //             text: {
    //               Config.menuAudioDeviceSymbols[modelData.description] 
    //               || Config.menuAudioDeviceSymbols['_fallback']
    //             }
    //             font: Fonts.tabler
    //             color: parent.textColor
    //           }
    //
    //           Text {
    //             anchors.verticalCenter: parent.verticalCenter
    //             text: modelData.description
    //             font: Fonts.menuBody
    //             color: parent.textColor
    //           }
    //         }
    //       }
    //     }
    //   }
    // }
  }
}

