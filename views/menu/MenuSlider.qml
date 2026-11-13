import QtQuick
import QtQuick.Layouts
import qs
import qs.style

MenuBlock {
  id: root
  spacing: Config.menu.sliderLabelSpacing

  required property string valueText
  required property real value
  required property real scrollStep

  signal moved(real sliderValue)

  RowLayout {
    width: parent.width
    spacing: Config.menu.sliderSpacing

    StyledSlider {
      Layout.fillWidth: true
      value: root.value
      stepSize: root.scrollStep
      wheelEnabled: true
      onMoved: root.moved(value)
    }

    Text {
      // Fixed width, so that the slider doesn't resize as the value changes.
      Layout.preferredWidth: valueMetrics.advanceWidth
      horizontalAlignment: Text.AlignRight
      text: root.valueText
      font: Config.menu.valueFont
      color: Colors.mOnSurface

      TextMetrics {
        id: valueMetrics
        text: '100%'
        font: Config.menu.valueFont
      }
    }
  }
}
