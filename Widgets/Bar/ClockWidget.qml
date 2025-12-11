import QtQuick
import Quickshell

import qs.Components
import qs.Services 

BarWidget {
  id: root
  text: ClockService.datetime  
}

