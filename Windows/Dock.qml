import QtQuick
import QtQuick.Layouts

import Quickshell

import qs.Theme


PanelWindow {
  id: root
  anchors.bottom: true
  implicitHeight: 0
  implicitWidth: popup.width * 0.75 
  color: 'transparent' //Colors.debug // DEBUG - this shouldn't be visible
  exclusiveZone: 0
  
  property bool dockIsVisible: true
  property int offset: 5

  PopupWindow {  // container window
    id: popup
    anchor {
      window: root
      rect.x: root.width/2 - width/2 // center horizontally
      // rect.y: -5
      adjustment: PopupAdjustment.None
      edges: Edges.Top | Edges.Center
      gravity: Edges.Top | Edges.Right
    }
    implicitHeight: 72 + root.offset
    implicitWidth: content.width + 64 // 32px padding on either side
    visible: dock.y <= height 
    color: 'transparent'

    Rectangle {
      id: dock
      width: parent.width
      height: parent.height - root.offset
      radius: height * 0.3
      color: Colors.applyAlpha(Colors.background, 0.5)
      border.color: Colors.applyAlpha(Colors.foreground, 0.25)
      border.width: 1
      
      // sliding in/out animation
      y: root.dockIsVisible ? 0 : parent.height
      Behavior on y {
        NumberAnimation { duration: 500; easing.type: Easing.OutExpo }
      }

      MouseArea {
        id: exitArea // leaving this mouseArea triggers the dock to disappear
        anchors.fill: parent
        hoverEnabled: true
        onExited: root.dockIsVisible = false
      }

      RowLayout {
        id: content
        anchors.centerIn: parent
        spacing: 64

        Text {text:'foo'; color: 'white'}
        Text {text:'bar'; color: 'white'}
        Text {text:'fiz'; color: 'white'}
        Text {text:'buz'; color: 'white'}
        Text {text:'baz'; color: 'white'}

      }
    }
  }

  MouseArea {
    id: enterArea  // hovering this MouseArea triggers the dock to appear
    width: parent.width
    height: parent.height
    hoverEnabled: true
    onEntered: root.dockIsVisible = true
   }
}
