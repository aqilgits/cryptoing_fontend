import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/crypto_controller.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonstyle = ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.grey),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
    );
    return Container(
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              height: 70,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: const Center(
              child: Text(
                'News',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            decoration: const BoxDecoration(color: Colors.green),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: 160.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: 160.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: 160.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: 160.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: 160.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Coin',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "Recommandation",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
            decoration: const BoxDecoration(color: Colors.green),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            height: 390,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/btc.png',
                            height: 50,
                          ),
                        ),
                        const Text(
                          "BTC",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      CryptoController().getCryptoData('BTC');
                    },
                    style: buttonstyle,
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  height: 80,
                ),
                Container(
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/eth.png',
                            height: 50,
                          ),
                        ),
                        const Text(
                          "ETH",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      CryptoController().getCryptoData('ETH');
                    },
                    style: buttonstyle,
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  height: 80,
                ),
                Container(
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/xrp.png',
                            height: 50,
                          ),
                        ),
                        const Text(
                          "XRP",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      CryptoController().getCryptoData('XRP');
                    },
                    style: buttonstyle,
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  height: 80,
                ),
                Container(
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/ada.png',
                            height: 50,
                          ),
                        ),
                        const Text(
                          "ADA",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      CryptoController().getCryptoData('ADA');
                    },
                    style: buttonstyle,
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  height: 80,
                ),
                Container(
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/doge.png',
                            height: 50,
                          ),
                        ),
                        const Text(
                          "DOGE",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      CryptoController().getCryptoData('DOGE');
                    },
                    style: buttonstyle,
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  height: 80,
                ),
              ],
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}
