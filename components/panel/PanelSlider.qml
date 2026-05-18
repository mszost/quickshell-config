import QtQuick
import Quickshell.Widgets
import qs.style
import qs.components.common

PanelRow {
  id: root
  colSpacing: 2
  bottomPadding: 10  // default looks too tall

  required property string text
  required property string valueText
  required property real value

  signal moved(real sliderValue)
  signal wheel(var wheel)

  Row {
    id: content

    Text {
      id: rowLabel
      text: root.text
      font: Fonts.menuSubheading
      color: Colors.primary
    }

    // Text {
    //   anchors.baseline: rowLabel.baseline
    //   text: `(${AudioService.activeSink?.description ?? ''})`
    //   font: Fonts.menuBody
    //   color: Colors.foreground
    // }
  }

  // Handles scrolling but allows clicks to pass through
  WrapperMouseArea {
    width: parent.width
    acceptedButtons: Qt.NoButton  
    onWheel: (wheel) => root.wheel(wheel)
    
    Row {
      anchors.fill: parent
      spacing: 5
      
      StyledSlider {
        id: slider
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width - valueLabel.width - parent.spacing
        value: root.value
        onMoved: root.moved(value)
      }
      
      Text {
        id: valueLabel
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        width: 45 
        text: root.valueText
        font: Fonts.jetbrains
        color: Colors.foreground
      }
    }
  }
}

