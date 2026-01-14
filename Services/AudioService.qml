pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire


Singleton {
  id: root

  readonly property string symbol: {
    if (AudioService.isMuted) return '\uF1C3'
    if (AudioService.volumeAsInt > 50) return '\ueb51'
    if (AudioService.volumeAsInt > 20) return '\ueb4f'
    if (AudioService.volumeAsInt > 0) return String.fromCodePoint(0x1019d)
    else return '\ueb50'
  }

  readonly property list<PwNode> availableSinks: {
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

  property PwNode activeSink: Pipewire.preferredDefaultAudioSink
  readonly property string activeSinkId: Pipewire.defaultAudioSink?.id ?? ''

  readonly property PwNode activeSource: Pipewire.defaultAudioSource
  readonly property string activeSourceId: Pipewire.defaultAudioSource?.id ?? ''

  property bool isMuted: Pipewire.defaultAudioSink?.audio.muted ?? false
 
  property real volume: Pipewire.defaultAudioSink?.audio?.volume ?? 0
  readonly property int volumeAsInt: Math.round(volume * 100)

  PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
  }

  function setVolume(val) {
    Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(1, val))
  }

  function setPreferredSink(node) {
    Pipewire.preferredDefaultAudioSink = node
  }

  function getSinkSymbol(description) {
    switch (description) {
      case 'Laptop Speakers': return '\ueb64'
      case 'Aux': return '\uea8b'
      case 'QC45': return '\ueabd'
      case 'Buds':
      case 'Buds2': return '\uf5a9'
      default: return '\ueb51'
    }
  }
}

