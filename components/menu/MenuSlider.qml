import QtQuick
import Quickshell.Widgets
import qs
import qs.style
import qs.components.common

MenuBlock {
  id: root
  colSpacing: 2 * Config.globalUiScale
  bottomPadding: 10 * Config.globalUiScale // default looks too tall

  required property string blockLabel
  required property string valueText
  required property real value

  signal moved(real sliderValue)
  signal wheel(var wheel)

  Row {
    id: content

    Text {
      id: rowLabel
      text: root.blockLabel
      font: Fonts.ibmPlexSans
      color: Colors.primary
    }
  }

  // Handles scrolling but allows clicks to pass through
  WrapperMouseArea {
    width: parent.width
    acceptedButtons: Qt.NoButton  
    onWheel: (wheel) => root.wheel(wheel)
    
    Row {
      anchors.fill: parent
      anchors.rightMargin: 6
      spacing: 5 * Config.globalUiScale
      
      StyledSlider {
        id: slider
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width - valueLabel.width
        value: root.value
        onMoved: root.moved(value)
      }
      
      Text {
        id: valueLabel
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        text: root.valueText
        font: Fonts.jetbrainsMono
        color: Colors.mOnSurface
      }
    }
  }
}

