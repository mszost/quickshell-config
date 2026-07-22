pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.style

Singleton {
  id: root

  readonly property string symbol: {
    if (AudioService.isMuted) return Icons.volumeMute
    if (AudioService.volumeAsInt > 50) return Icons.volume3
    if (AudioService.volumeAsInt > 25) return Icons.volume2
    if (AudioService.volumeAsInt > 0) return Icons.volume1
    return Icons.volume0
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

  readonly property list<PwNode> availableSources: {
    let nodes = Pipewire.nodes.values
    let deviceList = []
    for (let i=0; i<nodes.length; i++) {
      let node = nodes[i];
      if (!node.isSink && node.description && node.audio) {
        deviceList.push(node)
      }
    }
    return deviceList
  }

  property PwNode activeSink: Pipewire.preferredDefaultAudioSink
  readonly property string activeSinkId: Pipewire.defaultAudioSink?.id ?? ''

  property PwNode activeSource: Pipewire.preferredDefaultAudioSource
  readonly property string activeSourceId: Pipewire.defaultAudioSource?.id ?? ''

  property bool isMuted: Pipewire.defaultAudioSink?.audio?.muted ?? false
  property real volume: Pipewire.defaultAudioSink?.audio?.volume ?? 0
  readonly property int volumeAsInt: Math.round(volume * 100)

  property bool isSourceMuted: Pipewire.defaultAudioSource?.audio?.muted ?? false
  property real sourceVolume: Pipewire.defaultAudioSource?.audio?.volume ?? 0
  readonly property int sourceVolumeAsInt: Math.round(sourceVolume * 100)

  function setVolume(val) {
    if (Pipewire.defaultAudioSink?.audio) {
      Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(1, val))
    }
  }

  function toggleMute() {
    if (Pipewire.defaultAudioSink?.audio) {
      isMuted = !isMuted
    }
  }

  function setPreferredSink(node) {
    Pipewire.preferredDefaultAudioSink = node
  }

  function setSourceVolume(val) {
    if (Pipewire.defaultAudioSource?.audio) {
      Pipewire.defaultAudioSource.audio.volume = Math.max(0, Math.min(1, val))
    }
  }

  function toggleSourceMute() {
    if (Pipewire.defaultAudioSource?.audio) {
      isSourceMuted = !isSourceMuted
    }
  }

  function setPreferredSource(node) {
    Pipewire.preferredDefaultAudioSource = node
  }

  PwObjectTracker {
		objects: [ 
      Pipewire.defaultAudioSink,
      Pipewire.defaultAudioSource
    ]
  }
}

