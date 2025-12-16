import QtQuick

import Quickshell

import qs.Components
import qs.Services 


BarWidgetLite {
  id: root
  text: ClockService.datetime  
}

