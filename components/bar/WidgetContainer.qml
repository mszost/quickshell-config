import QtQuick
import qs

// Instantiates one or more widgets. Implemented by views/Bar.qml 

Row {
  id: section
  spacing: Config.bar.widgetSpacing
  
  property var widgets: []

  Repeater {
    model: section.widgets

    delegate: Loader {
      required property string modelData
      sourceComponent: WidgetRegistry.map[modelData] ?? null

      Component.onCompleted: {
        if (!sourceComponent)
          console.warn(`Config error: unknown widget "${modelData}"`)
      }
    }
  }
}

