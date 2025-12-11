// Generated from SVG file icons/tabler-icons/icons/outline/battery-charging-2.svg
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
            PathSvg { path: "M 4 9 Q 4 8.17157 4.58579 7.58579 Q 5.17157 7 6 7 L 17 7 Q 17.8284 7 18.4142 7.58579 Q 19 8.17157 19 9 L 19 9.5 Q 19 9.70711 19.1464 9.85355 Q 19.2929 10 19.5 10 Q 19.7071 10 19.8536 10.1464 Q 20 10.2929 20 10.5 L 20 13.5 Q 20 13.7071 19.8536 13.8536 Q 19.7071 14 19.5 14 Q 19.2929 14 19.1464 14.1464 Q 19 14.2929 19 14.5 L 19 15 Q 19 15.8284 18.4142 16.4142 Q 17.8284 17 17 17 L 12.5 17 " }
        }
        ShapePath {
            id: _qt_shapePath_1
            strokeColor: root.color 
            strokeWidth: root.weight
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            miterLimit: 4
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles
            PathSvg { path: "M 3 15 L 9 15 L 9 17 Q 9 17.8284 8.41421 18.4142 Q 7.82843 19 7 19 L 5 19 Q 4.17157 19 3.58579 18.4142 Q 3 17.8284 3 17 L 3 15 " }
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
            PathSvg { path: "M 6 22 L 6 19 " }
        }
        ShapePath {
            id: _qt_shapePath_3
            strokeColor: "#ff000000"
            strokeWidth: 2
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            miterLimit: 4
            fillColor: "transparent"
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic
            PathSvg { path: "M 4 15 L 4 12.5 " }
        }
        ShapePath {
            id: _qt_shapePath_4
            strokeColor: "#ff000000"
            strokeWidth: 2
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            miterLimit: 4
            fillColor: "transparent"
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic
            PathSvg { path: "M 8 15 L 8 12.5 " }
        }
    }
}
