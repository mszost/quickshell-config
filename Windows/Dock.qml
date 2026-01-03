import QtQuick
import QtQuick.Layouts
// import QtQuick.Effects

import Quickshell

import qs.Theme
import qs.Services


Scope {
  id: root
  property int offset: 5   // y-height offset from the bottom edge of the screen 
  property int buffer: 32  // so the exitArea can be slightly larger than the dock itself
  
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      anchors.bottom: true
      implicitHeight: 0
      implicitWidth: dock.width * 0.75 
      color: 'transparent'
      exclusiveZone: 0
      screen: modelData
      
      required property var modelData

      
      property var monitorObj: { // find the monitor object that matches the current screen's name
        var monitors = HyprlandService.monitors
        for (let i=0; i<monitors.length; i++) {
          if (monitors[i].name == modelData.name) {
            return monitors[i]
          }
        }
        return null
      }

      property bool monitorIsFocused: {
        const thisWsId = monitorObj.activeWorkspace.id
        const focusedWsId = HyprlandService.activeWorkspace.id
        return thisWsId == focusedWsId
      }

      property bool wsHasWindow: HyprlandService.isWorkspaceOccupied(HyprlandService.activeWorkspace.id) 

      property bool dockIsVisible: { false
      }
      // this must be a chid of panel, not root, so that the state is not shared between screens.
      
      MouseArea {
        id: enterArea  // hovering this MouseArea triggers the dock to appear
        anchors.fill: parent
        hoverEnabled: true
        onEntered: panel.dockIsVisible = true
      }

      PopupWindow {  // container window
        id: popup
        anchor {
          window: panel
          rect.x: panel.width/2 - width/2 // center horizontally
          adjustment: PopupAdjustment.None
          edges: Edges.Top | Edges.Center
          gravity: Edges.Top | Edges.Right
        }
        implicitHeight: dock.height + offset + buffer
        implicitWidth: dock.width + buffer 
        visible: dock.y <= height 
        
        color: 'transparent' //Colors.applyAlpha(Colors.debug, 0.1)

        MouseArea {
          id: exitArea // leaving this MouseArea triggers the dock to disappear
          anchors.fill: parent
          hoverEnabled: true
          onExited: panel.dockIsVisible = false
        }

        Rectangle {
          id: dock
          anchors.horizontalCenter: parent.horizontalCenter
          width: content.width + height
          height: 72
          radius: height * 0.3
          color: Colors.applyAlpha(Colors.background, 0.5)
          border.color: Colors.applyAlpha(Colors.foreground, 0.33)
          border.width: 1
          antialiasing: true
          
          // sliding in/out animation
          y: panel.dockIsVisible ? (parent.height - height - offset) : parent.height
          Behavior on y {
            NumberAnimation { duration: 500; easing.type: Easing.OutQuint }
          }
          
        // MultiEffect {
        //   source: dock
        //   anchors.fill: dock
        //   shadowBlur: 1.0
        //   shadowEnabled: true
        //   shadowColor: "black"
        //   shadowVerticalOffset: 20
        //   shadowHorizontalOffset: 20
        // }

          RowLayout {
            id: content
            anchors.centerIn: parent
            spacing: 64
            Text {text:'foo'; color: 'white'}
            Text {text:'bar'; color: 'white'}
            Text {text:'fiz'; color: 'white'}
            Text {text:'buz'; color: 'white'}
            Text {text:'baz'; color: 'white'}
            Text {text:'baz'; color: 'white'}
            Text {text:'baz'; color: 'white'}
            Text {text:'baz'; color: 'white'}
            Text {text:'baz'; color: 'white'}
          }
        }
      }
    }
  }
}
