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
  property real volume: Pipewire.defaultAudioSink.audio.volume
  property bool isMuted: Pipewire.defaultAudioSink.audio.muted
  // property bool isHeadphones: 
  property int volumeAsInt: Math.round(Pipewire.defaultAudioSink.audio.volume * 100)

}

