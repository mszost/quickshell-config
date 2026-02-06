// Watches for available system updates.

pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

import qs.style


Scope {
  id: root
  property string symbol: Icons.tabler['cloud-download']
  property int numUpdates: 0
  readonly property bool shouldShowWidget: numUpdates > 10

  // Using an event handler on the time instead of a Timer, 
  // probably less resource intense. Checks for updates every 10 minutes.
  property string currentMinute: ClockService.minute
  onCurrentMinuteChanged: if (currentMinute % 10 == 0) runCheck()

  Process {
    id: checkUpdatesProcess
    command: ['sh', '-c', 'checkupdates | wc -l']
    running: true
    stdout: SplitParser { onRead: data => { root.numUpdates = data; } }
  }

  function runCheck() {
    checkUpdatesProcess.running = true
  }
}

