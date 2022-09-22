import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:ionicons/ionicons.dart';

class MarketPrediction extends StatefulWidget {
  const MarketPrediction({Key? key}) : super(key: key);

  @override
  State<MarketPrediction> createState() => _MarketPredictionState();
}

class _MarketPredictionState extends State<MarketPrediction> {
  Widget? _child;

  @override
  void initState() {
    _child = const MarketPrediction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  width: 160.0,
                  color: Colors.red,
                ),
                Container(
                  width: 160.0,
                  color: Colors.blue,
                ),
                Container(
                  width: 160.0,
                  color: Colors.green,
                ),
                Container(
                  width: 160.0,
                  color: Colors.yellow,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
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
                    height: 50,
                    color: Colors.red,
                  ),
                  Container(
                    height: 50,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 50,
                    color: Colors.green,
                  ),
                  Container(
                    height: 50,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 50,
                    color: Colors.orange,
                  ),
                ],
              )),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}
