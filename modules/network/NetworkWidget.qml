import qs
import qs.style
import qs.views.bar

Widget {
  id: root
  font: Config.module.network.textFont
  icon: NetworkService.symbol
  text: NetworkService.networkName
}

