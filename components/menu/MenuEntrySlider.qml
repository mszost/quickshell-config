import QtQuick

import qs.components.common


Item {
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
          text: `(${AudioService.activeSink?.description ?? ''})`
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
}
