import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes

Item {
    id: root
    implicitWidth: 24
    implicitHeight: 24
    
    property color color: "white"
    property double weight: 2.0
    property AnimationsInfo animations : AnimationsInfo {}

    transform: [Scale { xScale: width / 24; yScale: height / 24 }]

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
            PathSvg { path: "M 7 6 Q 5.13553 7.57436 4.50943 9.93294 Q 3.88333 12.2915 4.7215 14.5833 Q 5.55968 16.8751 7.55971 18.2732 Q 9.55974 19.6714 12 19.6714 Q 14.4403 19.6714 16.4403 18.2732 Q 18.4403 16.8751 19.2785 14.5833 Q 20.1167 12.2915 19.4906 9.93294 Q 18.8645 7.57436 17 6 " }
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
            PathSvg { path: "M 12 4 L 12 12 " }
        }
    }
}
