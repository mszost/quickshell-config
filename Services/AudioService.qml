pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire


Scope {
  id: root
  
  // Bind the pipewire node so its volume will be tracked
	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
  }
  
  property PwNode node: Pipewire.defaultAudioSink
  property real volume: node.audio.volume
  property bool isMuted: node.audio.muted
  property bool isHeadphones: node

}

