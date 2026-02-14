
Item {
// Output device list block
  Rectangle {
    width: parent.width
    height: sinkListCol.height + (root.padding * 2.25)
    radius: root.blockRadius
    color: Colors.alpha(Colors.background, bgAlpha)

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
              text: {
                Config.menuAudioDeviceSymbols[modelData.description] 
                || Config.menuAudioDeviceSymbols['_fallback']
              }
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
