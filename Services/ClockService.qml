pragma Singleton

import Quickshell
import QtQuick


Singleton {
  id: root

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  readonly property string second: { 
    Qt.formatDateTime(clock.date, 's')
  }

  readonly property string minute: {
    Qt.formatDateTime(clock.date, 'm')
  }

  readonly property string hour: {
    Qt.formatDateTime(clock.date, 'h')
  }

  readonly property string datetime: {
    Qt.formatDateTime(clock.date, 'ddd,  MMM. d   •   h:mm AP')
  }

  readonly property string date: {
    Qt.formatDateTime(clock.date, 'yyyy-dddd-mmmm')
  }

  readonly property string time: {
    Qt.formatDateTime(clock.date, 'h:mm:ss')
  }
}

