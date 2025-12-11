// Generated from SVG file icons/tabler-icons/icons/outline/battery-exclamation.svg
import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes

Item {
    id:root
    
    implicitWidth: 24
    implicitHeight: 24
    transform: [Scale { xScale: width / 24; yScale: height / 24 }]

    property color color: "white"
    property double weight: 2
    property AnimationsInfo animations : AnimationsInfo {}

    component AnimationsInfo : QtObject {
        property bool paused: false
        property int loops: 1
        signal restart()
    }

    Shape {
        preferredRendererType: Shape.CurveRenderer
        id: _qt_node0
        ShapePath {
            id: _qt_shapePath_0
            strokeColor: root.color
            strokeWidth: root.weight
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            miterLimit: 4
            fillColor: "transparent"
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic
            PathSvg { path: "M 9 17 L 17 17 Q 17.8288 17 18.4144 16.4144 Q 19 15.8287 19 15 L 19 14.5 Q 19 14.293 19.1465 14.1465 Q 19.293 14 19.5 14 Q 19.707 14 19.8535 13.8535 Q 20 13.707 20 13.5 L 20 10.5 Q 20 10.293 19.8535 10.1465 Q 19.707 10 19.5 10 Q 19.293 10 19.1465 9.8535 Q 19 9.707 19 9.5 L 19 9 Q 19 8.17125 18.4144 7.58563 Q 17.8288 7 17 7 L 6 7 Q 5.17125 7 4.58563 7.58563 Q 4 8.17125 4 9 L 4 12 " }
        }
        ShapePath {
            id: _qt_shapePath_1
            strokeColor: root.color
            strokeWidth: root.weight
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            miterLimit: 4
            fillColor: "transparent"
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic
            PathSvg { path: "M 5 16 L 5 19 " }
        }
        ShapePath {
            id: _qt_shapePath_2
            strokeColor: root.color
            strokeWidth: root.weight
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            miterLimit: 4
            fillColor: "transparent"
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic
            PathSvg { path: "M 5 22 L 5 22.01 " }
        }
    }
}
