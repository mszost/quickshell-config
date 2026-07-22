import QtQuick
import qs
import qs.style

Item {
  id: root

  readonly property var widgetContainerPos: parent.position

  // Pill (bgRect)
  property int pillHeight: Config.barPillHeight
  property int pillPadding: 5
  property alias pillMargins: bgRect.anchors.margins

  readonly property bool hasLabel: label.text !== ""
  readonly property bool hasIcon: icon.text !== ""

  implicitWidth: hasLabel ? content.implicitWidth + (pillPadding * 2) : pillHeight
  implicitHeight: pillHeight

  // RowLayout
  property alias spacing: content.spacing
  property alias layoutDirection: content.layoutDirection

  // Text items (label and icon)
  property alias text: label.text
  property alias textFamily: label.font.family 
  property alias textSize: label.font.pixelSize
  property alias textWeight: label.font.weight

  property alias icon: icon.text
  property alias iconFamily: icon.font.family
  property alias iconSize: icon.font.pixelSize
  property alias iconWeight: icon.font.weight

  // Mouse
  property alias mouseArea: ma
  signal clicked()

  // Colors and animations
  property color normalColor: Colors.foreground
  property color hoverColor: Colors.primary //Colors.mOnSurfaceVariant
  property color animatedColor: ma.containsMouse ? root.hoverColor : root.normalColor

  property alias animDuration: anim.duration
  
  Behavior on animatedColor {
    ColorAnimation {
      id: anim
      duration: 100
      easing.type: Easing.InOutQuad
    }
  }

  // Pill
  Rectangle {
    id: bgRect
    anchors.fill: parent
    radius: height
    color: Colors.surface
  }

  Row {
    id: content
    anchors.centerIn: parent
    layoutDirection: Qt.LeftToRight 
    spacing: 1

    Text {
      id: label
      visible: root.hasLabel
      anchors.verticalCenter: parent.verticalCenter
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
      font.family: Fonts.barLabel.family
      font.pixelSize: Fonts.barLabel.pixelSize
      font.weight: Fonts.barLabel.weight
      color: root.animatedColor
    }
          
    Text {
      id: icon
      visible: root.hasIcon
      anchors.verticalCenter: parent.verticalCenter
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
      font.family: Fonts.barIcon.family
      font.pixelSize: Fonts.barIcon.pixelSize
      font.weight: Fonts.barIcon.weight 
      color: root.animatedColor
    }
  }

  MouseArea {
    id: ma
    anchors.fill: parent
    anchors.margins: -8 
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clicked()
  }
}

