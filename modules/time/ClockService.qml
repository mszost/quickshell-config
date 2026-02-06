pragma Singleton

import Quickshell
import QtQuick


Singleton {
  id: root

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  readonly property string hour: {
    Qt.formatDateTime(clock.date, 'h')
  }

  readonly property string minute: {
    Qt.formatDateTime(clock.date, 'm')
  }

  readonly property string datetime: {
    Qt.formatDateTime(clock.date, 'h:mm AP  •  ddd, MMM. d')
  }

  readonly property string date: {
    Qt.formatDateTime(clock.date, 'yyyy-dddd-mmmm')
  }

  readonly property string time: {
    Qt.formatDateTime(clock.date, 'h:mm:ss')
  }

  function format(fmtString) {
    return Qt.formatDateTime(clock.date, fmtString)
  }
}

