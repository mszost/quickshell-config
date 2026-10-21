pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  function format(fmtString) {
    return Qt.formatDateTime(clock.date, fmtString)
  }
}
