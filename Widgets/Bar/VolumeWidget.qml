import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire

import qs.Theme
import qs.Components
import qs.Services


BarWidget {
  id: root
  // text: AudioService.isMuted ? 'Muted' : AudioService.volumeAsInt + '%'
  iconSize: 18
  spacing: 1
  onClicked: menuState = !menuState // Hyprland.dispatch("exec pavucontrol") 
  normalColor: AudioService.volumeAsInt > 100 ? Colors.red : Colors.foreground
  
  icon: {
    // if (<sink connected is headphones>) return '\uFA3C' || '\uEABD'
    if (AudioService.isMuted) return '\uF1C3'
    if (AudioService.volumeAsInt > 45) return '\uEB51'
    if (AudioService.volumeAsInt > 0)  return '\uEB4F'
    else return '\uEB50'
  }
 
  // Scroll event handler
  mouseArea.onWheel: (wheelEvent) => {
    let step = 0.02
    if (wheelEvent.angleDelta.y > 0) AudioService.setVolume(AudioService.volume + step)
    if (wheelEvent.angleDelta.y < 0) AudioService.setVolume(AudioService.volume - step)
  }


  // Menu
  property alias menuState: menu.menuIsOpen
  
  Menu {
    id: menu
    boundItem: root
    menuIsOpen: root.menuState

    MenuItem {
      text: "Volume"
      textHoverColor: Colors.foreground  // item remains hoverable but this prevents the appearance from changing
      bgHoverColor: "transparent"
    }

    
    RowLayout {  // wrapper
      id: wrapper
      Layout.preferredHeight: menu.rowHeight + 5 
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignBottom
      spacing: 5

      Item {Layout.preferredWidth: wrapper.width * 0.08}  // left margin

      Text {
        text: AudioService.isMuted ? 'Muted' : AudioService.volumeAsInt + '%'
        font: Fonts.barText
        color: Colors.foreground
      }

      Rectangle {  // volume slider container
        Layout.preferredHeight: 8
        Layout.fillWidth: true
        radius: height/2
        color: Colors.applyAlpha(Colors.foreground,0.2)
        
        Rectangle { // volume slider -- this is not yet interactable. 
          height: parent.height
          width: parent.width * (AudioService.volumeAsInt / 100)
          radius: parent.radius
          color: Colors.foreground
        }
      }


      Item {Layout.preferredWidth: wrapper.width * 0.1}  // right margin
    }


    Rectangle {  // wrapper
      height: menu.rowHeight
      width: parent.width 
      color: "transparent"
      Rectangle {  // separator line
        height: 1
        width: parent.width * 0.75
        anchors.centerIn: parent
        color: Colors.applyAlpha(Colors.foreground,0.2)
      }
    }

    MenuItem {
      text: "Output Device"
      textHoverColor: Colors.foreground  // item remains hoverable but this prevents the appearance from changing
      bgHoverColor: "transparent"
    }

    // Dynamically renders the list of available audio sinks (output devices)
    Repeater {
      model: AudioService.availableSinks
      
      MenuItemAlt {
        property bool sinkIsActive: modelData.id == AudioService.activeSinkId

        property color entryColor: {
          if (m.containsMouse) return Colors.color2
          else if (sinkIsActive) return Colors.foreground
          else return Colors.applyAlpha(Colors.foreground, 0.5)
          // m.containsMouse ? Colors.color2 : 
        }

        Behavior on entryColor {
          ColorAnimation { duration: 100; easing.type: Easing.InOutQuad }
        }
        
        RowLayout {
          id: row
          spacing: 6
          
          Text { 
            text: {
              switch (modelData.description) {
                case 'Laptop Speakers': return '\ueb64'
                case 'Aux': return '\uea8b'
                case 'QC45': return '\ueabd'
                case 'Buds':
                case 'Buds2': return '\uf5a9'
                default: return '\ueb51'
              }
            }
            font.family: Fonts.barIcon.family
            font.pixelSize: 18
            color: entryColor
          }

          Text {
            id: textSinkName
            text: modelData.description
            font: Fonts.barText
            color: entryColor
          }
        }

        MouseArea { // MouseArea filling each row 
          id: m
          anchors.fill: parent
          anchors.margins: -2
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: Pipewire.preferredDefaultAudioSink = modelData  // set default audio output to the clicked sink 
        }
      }
    }

    
    Rectangle {  // wrapper
      height: menu.rowHeight
      width: parent.width 
      color: "transparent"
      Rectangle {  // separator line
        height: 1
        width: parent.width * 0.75
        anchors.centerIn: parent
        color: Colors.applyAlpha(Colors.foreground,0.2)
      }
    }

    MenuItem {
      text: "Open Mixer"
      onClicked: {
        Hyprland.dispatch('exec pavucontrol -t 3')
        root.menuState = false 
      } 
    }
  }

 }

