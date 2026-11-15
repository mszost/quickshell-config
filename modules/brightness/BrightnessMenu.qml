import QtQuick
import QtQuick.Layouts
import qs
import qs.style
import qs.components
import qs.views.menu

MenuWindow {
  id: root

  readonly property QtObject sunsetCfg: Config.module.hyprsunset

  // Fade for the night light sliders while stopped. Mutable so that it can animate.
  property real sunsetAlpha: HyprsunsetService.running ? 1 : sunsetCfg.inactiveAlpha

  Ease on sunsetAlpha { preset: Motion.fade }

  MenuTitle {
    text: 'Display'
    icon: BrightnessService.symbol
  }

  MenuSlider {
    label: Config.module.brightness.menuLabel || BrightnessService.deviceName
    valueText: `${BrightnessService.percent}%`
    value: BrightnessService.brightness
    scrollStep: Config.module.brightness.scrollStep
    onMoved: (sliderValue) => BrightnessService.setBrightness(sliderValue)
  }

  // Night light: on/off header, with temperature and gamma sliders below.
  MenuBlock {
    spacing: Config.menu.blockSpacing

    RowLayout {
      width: parent.width
      spacing: Config.menu.rowSpacing

      Text {
        text: HyprsunsetService.symbol
        font: Config.menu.itemIconFont
        color: HyprsunsetService.running ? Colors.primary : Colors.mOnSurfaceVariant

        Ease on color { preset: Motion.fade }
      }

      Text {
        Layout.fillWidth: true
        text: 'Night light'
        font: Config.menu.itemFont
        color: Colors.mOnSurface
      }

      StyledSwitch {
        checked: HyprsunsetService.running
        // Clicking breaks the binding; restore it so the service stays the source of truth.
        onToggled: {
          HyprsunsetService.setRunning(checked)
          checked = Qt.binding(() => HyprsunsetService.running)
        }
      }
    }

    // Values still apply while stopped (they're used on the next start), so this only dims.
    // Each part fades on its own, so the sliders can keep their handles opaque.
    GridLayout {
      width: parent.width
      columns: 3
      columnSpacing: Config.menu.sliderSpacing
      rowSpacing: 0

      Text {
        opacity: root.sunsetAlpha
        text: 'Temperature'
        font: Config.menu.labelFont
        color: Colors.mOnSurfaceVariant
      }

      StyledSlider {
        Layout.fillWidth: true
        value: HyprsunsetService.temperatureNorm
        stepSize: root.sunsetCfg.temperatureStep
        wheelEnabled: true
        fadeOpacity: root.sunsetAlpha
        onMoved: HyprsunsetService.setTemperatureNorm(value)
      }

      Text {
        // Reserves the widest value's width, so the slider doesn't resize as the value changes.
        Layout.minimumWidth: temperatureMetrics.advanceWidth
        opacity: root.sunsetAlpha
        horizontalAlignment: Text.AlignRight
        text: `${HyprsunsetService.temperature}K`
        font: Config.menu.valueFont
        color: Colors.mOnSurface

        TextMetrics {
          id: temperatureMetrics
          text: `${root.sunsetCfg.maxTemperature}K`
          font: Config.menu.valueFont
        }
      }

      Text {
        opacity: root.sunsetAlpha
        text: 'Gamma'
        font: Config.menu.labelFont
        color: Colors.mOnSurfaceVariant
      }

      StyledSlider {
        Layout.fillWidth: true
        value: HyprsunsetService.gammaNorm
        stepSize: root.sunsetCfg.gammaStep
        wheelEnabled: true
        fadeOpacity: root.sunsetAlpha
        onMoved: HyprsunsetService.setGammaNorm(value)
      }

      Text {
        Layout.minimumWidth: gammaMetrics.advanceWidth
        opacity: root.sunsetAlpha
        horizontalAlignment: Text.AlignRight
        text: `${HyprsunsetService.gamma}%`
        font: Config.menu.valueFont
        color: Colors.mOnSurface

        TextMetrics {
          id: gammaMetrics
          text: `${root.sunsetCfg.maxGamma}%`
          font: Config.menu.valueFont
        }
      }
    }
  }
}
