// Watches for available system updates.
// Runs an automatic check every hour.

pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Scope {
  id: root
  property string symbol: '\uea71'
  property int numUpdates: 0
  readonly property bool shouldShowWidget: numUpdates > 10

  // Using an event handler on the hour instead of a Timer,
  // since this is such a large time scale
  property string currentHour: ClockService.hour
  onCurrentHourChanged: runCheck()

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

