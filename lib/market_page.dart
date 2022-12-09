import 'package:cryptoingfontend/controller/crypto_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  State<Market> createState() => _MarketState();
}

class Wrapper {
  List prices = [];
}

pricedata() async {
  Wrapper wrapper = Wrapper();
  List price = await CryptoController().getCryptoPrice('DOGE');
  for (var i = 0; i < price.length; i++) {
    wrapper.prices.add(price[i]);
  }
  return price;
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    pricedata();
    return Container();
  }
}
