pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

import qs.style


Singleton {
  id: root

  readonly property string symbol: {
    if (AudioService.isMuted) return Icons.tabler['volume-mute']
    if (AudioService.volumeAsInt > 50) return Icons.tabler['volume-high']
    if (AudioService.volumeAsInt > 20) return Icons.tabler['volume-mid']
    if (AudioService.volumeAsInt > 0) return Icons.tabler['volume-low']
    return Icons.tabler['volume-zero']
  }

  readonly property list<PwNode> availableSinks: {
    let nodes = Pipewire.nodes.values
    let deviceList = []
    for (let i=0; i<nodes.length; i++) {
      if (nodes[i].isSink && nodes[i].description) {
        deviceList.push(nodes[i])
      }
    }
    return deviceList
  }

  // property list<PwNode> availableSources: {
  //   let nodes = Pipewire.nodes.values
  //   let deviceList = []
  //   for (let i=0; i<nodes.length; i++) {
  //     if (!nodes[i].isSink && nodes[i].description) {
  //       console.log(nodes[i].description)
  //       deviceList.push(nodes[i])
  //     }
  //   }
  //   return deviceList
  // }
  //
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
}

