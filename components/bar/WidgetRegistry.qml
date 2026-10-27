pragma Singleton

import QtQuick
import Quickshell
import qs.modules.audio
import qs.modules.battery
import qs.modules.brightness
import qs.modules.core
import qs.modules.hyprland
import qs.modules.network
import qs.modules.session
import qs.modules.system
import qs.modules.time
import qs.modules.tray

Singleton {
  readonly property var map: ({
    _debug: _debug,
    audio: audio,
    battery: battery,
    brightness: brightness,
    clock: clock,
    session: session,
    cputemp: cputemp,
    network: network,
    workspaces: workspaces
  })

  Component { id: _debug;     DebuggingWidget {}  }
  Component { id: audio;      AudioWidget {}      }
  Component { id: battery;    BatteryWidget {}    }
  Component { id: brightness; BrightnessWidget {} }
  Component { id: clock;      ClockWidget {}      }
  Component { id: network;    NetworkWidget {}    }
  Component { id: session;    SessionWidget {}    }
  Component { id: cputemp;    CpuTempWidget {}    }
  Component { id: tray;       TrayWidget {}       }
  Component { id: workspaces; WorkspacesWidget {} }
}

