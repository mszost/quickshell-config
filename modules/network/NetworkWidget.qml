import qs.style
import qs.components.bar

Widget {
  id: root
  font: Config.widget.network.textFont || Config.widget.textFont
  // iconSize: 12
  icon: NetworkService.symbol
  // text: NetworkService.networkName
}
