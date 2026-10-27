pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs
import qs.style

Singleton {
  id: root

  readonly property QtObject cfg: Config.widget.network

  // Public properties
  readonly property bool ethernet: _state.ethernet
  readonly property bool wifiEnabled: _state.wifiEnabled
  readonly property string wifiStatus: _state.wifiStatus  // 'connected' | 'limited' | 'connecting' | 'disconnected' | 'disabled'
  readonly property bool wifi: wifiStatus === 'connected'
  readonly property string networkName: _state.networkName
  readonly property int networkStrength: _state.networkStrength

  readonly property string signalSymbol: {
    if (networkStrength > cfg.signalHigh) return Icons.wifi4
    if (networkStrength > cfg.signalMedium) return Icons.wifi3
    if (networkStrength > 0) return Icons.wifi2
    return Icons.worldX
  }

  readonly property string symbol: {
    if (ethernet) return Icons.ethernet
    switch (wifiStatus) {
      case 'connecting': return Icons.router
      case 'disabled': return Icons.wifiOff
      case 'connected':
      case 'limited': return signalSymbol
      default: return Icons.worldX
    }
  }

  // Internal properties
  // All public properties derive from this one object, which is replaced
  // entirely after each refresh. Bindings above can never observe a half-updated state.
  property var _state: ({
    ethernet: false,
    wifiEnabled: false,
    wifiStatus: 'disconnected',
    networkName: '',
    networkStrength: 0
  })
  property bool _refreshQueued: false

  readonly property string _separator: '---'

  // `parse()` depends on this ordering.
  // [0] wifi radio, [1] devices, [2] global connectivity, [3] access points.
  readonly property list<string> _queries: [
    'nmcli radio wifi',
    'nmcli -t -f TYPE,STATE,CONNECTION device status',
    'nmcli -t -f CONNECTIVITY general',
    'nmcli -t -f IN-USE,SIGNAL device wifi list'
  ]

  function refresh() {
    // Don't overlap runs; remember the request and re-run once the current one exits.
    if (statusQuery.running) {
      _refreshQueued = true
      return
    }
    statusQuery.running = true
  }

  // Terse-mode line: TYPE:STATE:CONNECTION, where ':' inside CONNECTION is escaped as '\:'.
  function parseDevice(line) {
    const fields = line.split(':')
    return {
      type: fields[0],
      state: fields[1] ?? '',
      connection: fields.slice(2).join(':').replace(/\\:/g, ':')
    }
  }

  function wifiStatusOf(device, connectivity) {
    if (!device) return 'disconnected'
    if (device.state.startsWith('connected')) return connectivity === 'limited' ? 'limited' : 'connected'
    if (device.state.startsWith('connecting')) return 'connecting'
    if (device.state === 'unavailable') return 'disabled'
    return 'disconnected'
  }

  function parse(output) {
    const sections = [[], [], [], []]
    let index = 0
    for (const line of output.split('\n')) {
      if (line === _separator) index++
      else if (line.trim() !== '' && sections[index]) sections[index].push(line)
    }
    const [radio, devices, connectivity, accessPoints] = sections

    const parsedDevices = devices.map(parseDevice)
    const ethernetDevice = parsedDevices.find(d => d.type === 'ethernet' && d.state.startsWith('connected'))
    const wifiDevice = parsedDevices.find(d => d.type === 'wifi')

    const status = wifiStatusOf(wifiDevice, connectivity[0]?.trim())
    const wifiActive = status === 'connected' || status === 'limited'
    const activeAccessPoint = accessPoints.find(line => line.startsWith('*:'))

    return {
      ethernet: ethernetDevice !== undefined,
      wifiEnabled: radio[0]?.trim() === 'enabled',
      wifiStatus: status,
      networkName: ethernetDevice?.connection ?? (wifiActive ? wifiDevice.connection : ''),
      // Reset to 0 when not on wifi so a stale value can't leak into the icon.
      networkStrength: wifiActive && activeAccessPoint ? (parseInt(activeAccessPoint.split(':')[1]) || 0) : 0
    }
  }

  Process {
    id: statusQuery
    command: ['sh', '-c', root._queries.join('; echo ' + root._separator + '; ')]
    // nmcli's state strings are localized; force English so parsing is reliable.
    environment: ({ LANG: 'C', LC_ALL: 'C' })
    stdout: StdioCollector {
      onStreamFinished: root._state = root.parse(text)
    }
    onExited: {
      if (!root._refreshQueued) return
      root._refreshQueued = false
      running = true
    }
  }

  Timer {
    interval: root.cfg.pollInterval
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }

  // Connection changes (plug/unplug, join/leave a network, radio toggled) trigger an
  // immediate refresh instead of waiting for the next poll.
  Process {
    command: ['nmcli', 'monitor']
    running: true
    stdout: SplitParser { onRead: eventDebounce.restart() }
  }

  Timer {
    id: eventDebounce
    interval: root.cfg.eventDebounce
    onTriggered: root.refresh()
  }
}

