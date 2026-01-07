pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire


Singleton {
  id: root

  readonly property string symbol: {
    if (AudioService.isMuted) return '\uF1C3'
    if (AudioService.volumeAsInt > 45) return '\uEB51'
    if (AudioService.volumeAsInt > 0)  return '\uEB4F'
    else return '\uEB50'
  }

  property var availableSinks: {
    let nodes = Pipewire.nodes.values
    let deviceList = []
    for (let i=0; i<nodes.length; i++) {
      if (nodes[i].isSink && nodes[i].description) deviceList.push(nodes[i])
    }
    return deviceList
  }

  // property var availableSources: {
  //   let nodes = Pipewire.nodes.values
  //   let deviceList = []
  //   for (let i=0; i<nodes.length; i++) {
  //     if (!nodes[i].isSink && nodes[i].id) console.log(nodes[i].id)//deviceList.push(nodes[i])
  //   }
  //   return deviceList
  // }
  
  property PwNode activeSink: Pipewire.defaultAudioSink
  property string activeSinkId: Pipewire.defaultAudioSink?.id ?? ''

  property PwNode activeSource: Pipewire.defaultAudioSource
  property string activeSourceId: Pipewire.defaultAudioSource?.id ?? ''

  
  property real volume: Pipewire.defaultAudioSink?.audio?.volume ?? 0
  property int volumeAsInt: Math.round(volume * 100)
  

	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
  }

  function setVolume(val) {
    Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(1, val))
  }
 }

