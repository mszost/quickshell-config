import qs
import qs.style
import qs.components.bar

Widget {
  id: root
  font: Config.widget.network.textFont || Config.widget.textFont
  icon: NetworkService.symbol
  text: NetworkService.networkName
}

