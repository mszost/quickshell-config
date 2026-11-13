import QtQuick
import qs

// Instantiates one or more widgets. Implemented by views/bar/Bar.qml 

Row {
  id: section
  spacing: Config.widget.pillSpacing
  
  property var widgets: []

  WidgetRegistry { id: registry }

  Repeater {
    model: section.widgets

    delegate: Loader {
      required property string modelData
      sourceComponent: registry.map[modelData] ?? null

      Component.onCompleted: {
        if (!sourceComponent)
          console.warn(`Config error: unknown widget "${modelData}"`)
      }
    }
  }
}

