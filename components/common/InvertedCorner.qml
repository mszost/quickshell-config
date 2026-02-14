import QtQuick
import QtQuick.Shapes

Shape {
    id: root

    property int radius: 16
    property color color: "black"

    // Implicit size matches the radius
    implicitWidth: radius
    implicitHeight: radius

    // Optimization: Cache as texture to save GPU usage on static menus
    layer.enabled: true
    layer.samples: 4
    layer.smooth: true

    ShapePath {
        fillColor: root.color
        strokeWidth: 0
        strokeColor: "transparent"

        // Draw a "web" that fills the corner.
        // By default, this draws the Bottom-Right material, leaving a Top-Left void.
        // We will rotate this component to fit other corners.
        
        startX: root.width
        startY: 0
        
        // Line down to bottom-right
        PathLine { x: root.width; y: root.height }
        
        // Line left to bottom-left
        PathLine { x: 0; y: root.height }
        
        // Concave Arc back to top-right
        PathArc {
            x: root.width
            y: 0
            radiusX: root.width
            radiusY: root.height
            useLargeArc: false
            direction: PathArc.CounterClockwise
        }
    }
}
