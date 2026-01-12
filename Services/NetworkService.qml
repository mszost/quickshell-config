pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

// Heavily based on https://github.com/end-4/dots-hyprland/

Singleton {
  id: root

  property bool ethernet: false
  property bool wifi: true
  // property bool vpn: false
  property bool wifiEnabled: false
  property string networkName
  property string wifiStatus
  property int networkStrength

  property string symbol: {
    if (ethernet) return '\ueb9d'
    if (wifiEnabled) {
      if (networkStrength > 0) return '\ueb52' // wifi
      if (networkStrength > 0) return '\ueba5' // wifi-2
      if (networkStrength > 0) return '\ueba4' // wifi-1
      if (networkStrength > 0) return '\ueba3' // wifi-0
      return '\uf9e6' // world-question  // this is user-disconnected state
    } 
    if (wifiStatus === 'connecting') return '\ueb18' // router
    if (wifiStatus === 'disconnected') return '\uf9eb' // world-x
    if (wifiStatus === 'disabled') return '\uecfa' // wifi-off
    return '\uea06' // alert-triangle
  }

  // re-run all checks on a 30-second interval
  Timer {
    interval: 30000
    running: true
    repeat: true
    onTriggered: {
      updateConnectionType.startCheck()
      wifiStatusProcess.running = true
      updateNetworkName.running = true
      updateNetworkStrength.running = true
    }
  }

  Process {
    id: updateNetworkName
    command: ["sh", "-c", "nmcli -t -f NAME c show --active | head -1"]
    running: true
    stdout: SplitParser { onRead: data => { root.networkName = data; } }
  }

  Process {
    id: updateNetworkStrength
    running: true
    command: ["sh", "-c", "nmcli -f IN-USE,SIGNAL,SSID device wifi | awk '/^\*/{if (NR!=1) {print $2}}'"]
    stdout: SplitParser { onRead: data => { root.networkStrength = parseInt(data); } }
  }

  Process {
    id: wifiStatusProcess
    command: ["nmcli", "radio", "wifi"]
    Component.onCompleted: running = true
    environment: ({ LANG: "C", LC_ALL: "C" })
    stdout: StdioCollector { onStreamFinished: { root.wifiEnabled = text.trim() === "enabled"; } }
    }

  Process {
    id: updateConnectionType
    command: ["sh", "-c", "nmcli -t -f TYPE,STATE d status && nmcli -t -f CONNECTIVITY g"]
    running: true
    stdout: SplitParser { onRead: data => { updateConnectionType.buffer += data + "\n"; } }
    
    property string buffer

    function startCheck() {
      buffer = "";
      updateConnectionType.running = true;
    }

    onExited: (exitCode, exitStatus) => {
      const lines = updateConnectionType.buffer.trim().split('\n');
      const connectivity = lines.pop() // none, limited, full
      let hasEthernet = false;
      let hasWifi = false;
      let wifiStatus = "disconnected";
      lines.forEach(line => {
        if (line.includes("ethernet") && line.includes("connected"))
          hasEthernet = true;
        else if (line.includes("wifi:")) {  
          if (line.includes("disconnected")) {
            wifiStatus = "disconnected"
          }
          else if (line.includes("connected")) {
            hasWifi = true;
            wifiStatus = "connected"
            
            if (connectivity === "limited") {
              hasWifi = false;
              wifiStatus = "limited"
            }
          }
          else if (line.includes("connecting")) {
            wifiStatus = "connecting"
          }
          else if (line.includes("unavailable")) {
            wifiStatus = "disabled"
          }
        }
      });
      root.wifiStatus = wifiStatus;
      root.ethernet = hasEthernet;
      root.wifi = hasWifi;
    }
  }
}

