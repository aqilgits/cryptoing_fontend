import 'dart:math' as math;
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cryptoingfontend/controller/crypto_controller.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Market extends StatefulWidget {
  final String cryptoname;
  const Market(this.cryptoname, {Key? key}) : super(key: key);

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  List<FlSpot> pricedata = [];
  List<FlSpot> predsdata = [];
  bool loading = false;
  String current = '';
  List<double> maxi = [];
  double maximum = 0.0;
  double minimum = 0.0;
  late Future prices;
  late Future preds; //for data featching status
  final List<Color> gradientColors2 = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a)
  ];
  final List<Color> gradientColors = [
    const Color.fromARGB(255, 255, 0, 251),
    const Color.fromARGB(255, 0, 16, 246)
  ];
  @override
  void initState() {
    // getData2();
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    prices = CryptoController().getCryptoPrice(widget.cryptoname);
    dynamic valueprice = await prices;
    preds = CryptoController().getCryptoPreds(widget.cryptoname);
    dynamic valuepreds = await preds;

    for (int i = 35; i < valueprice.length; i++) {
      print(valueprice[i]);
      double value = (valueprice[74] * 10000).round() / 10000;
      maxi = valueprice.cast<double>();
      maximum = maxi.getRange(35, 74).reduce(max);
      current = value.toString();
      pricedata = List.generate(40, (index) {
        double value = (valueprice[index + 35] * 10000).round() / 10000;

        return FlSpot(index.toDouble(), value);
      });
    }
    for (int i = 35; i < valuepreds.length; i++) {
      print(valuepreds[i]);
      predsdata = List.generate(40, (index) {
        double value = (valuepreds[index + 35] * 10000).round() / 10000;
        maxi = valuepreds.cast<double>();
        minimum = maxi.getRange(35, 74).reduce(min);
        return FlSpot(index.toDouble() + 1, value);
      });
    }
    loading = false;
    setState(() {});
  }

  SideTitles get bottomTitles {
    return SideTitles(
      reservedSize: 50,
      showTitles: true,
      getTitlesWidget: (value, meta) {
        // String text = '';
        switch (value.toInt()) {
          case 40:
            return Transform.rotate(
                alignment: Alignment.centerRight,
                angle: -60 * math.pi / 180,
                child: Text(DateFormat('dd/MM/yy').format(DateTime.now())));

          case 35:
            return Transform.rotate(
              alignment: Alignment.centerRight,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(const Duration(days: 5)))),
            );
          case 30:
            return Transform.rotate(
              alignment: Alignment.centerRight,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(const Duration(days: 10)))),
            );
          case 25:
            return Transform.rotate(
              alignment: Alignment.centerRight,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(const Duration(days: 15)))),
            );
          case 20:
            return Transform.rotate(
              alignment: Alignment.centerRight,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(const Duration(days: 20)))),
            );
          case 15:
            return Transform.rotate(
              alignment: Alignment.centerRight,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(const Duration(days: 25)))),
            );
          case 10:
            return Transform.rotate(
              alignment: Alignment.centerRight,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(const Duration(days: 30)))),
            );
          case 5:
            return Transform.rotate(
              alignment: Alignment.centerRight,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(const Duration(days: 35)))),
            );
            ;
          case 0:
            return Transform.rotate(
              alignment: Alignment.centerRight,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(const Duration(days: 40)))),
            );
        }
        return const Text('');
      },
    );
  }

  SideTitles get leftTitles {
    return SideTitles(
      reservedSize: 50,
      showTitles: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    String name = ("assets/images/" + widget.cryptoname + ".png");
    return MaterialApp(
      home: Scaffold(
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Image.asset(
                                  name,
                                  height: 50,
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  widget.cryptoname,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: const Center(
                          child: Text(
                            'Prediction',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        decoration: const BoxDecoration(color: Colors.green),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Current price',
                                  style: TextStyle(fontSize: 30),
                                ),
                                Text(
                                  '\$' + current,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .6,
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 20, 40, 30),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .5,
                          child: LineChart(
                            LineChartData(
                              minX: 0,
                              maxX: 40,
                              minY: minimum - (minimum * (2 / 100)),
                              maxY: maximum,
                              gridData: FlGridData(
                                show: false,
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: const Border(
                                  top: BorderSide.none,
                                  right: BorderSide.none,
                                  left: BorderSide(width: 1.0),
                                  bottom: BorderSide(width: 1.0),
                                ),
                              ),
                              lineBarsData: [
                                // // The red line
                                LineChartBarData(
                                    dotData: FlDotData(
                                      show: false,
                                    ),
                                    spots: pricedata,
                                    isCurved: true,
                                    barWidth: 3,
                                    gradient:
                                        LinearGradient(colors: gradientColors),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: gradientColors
                                            .map((color) =>
                                                color.withOpacity(0.06))
                                            .toList(),
                                      ),
                                    )),
                                LineChartBarData(
                                  dotData: FlDotData(
                                    show: false,
                                  ),
                                  spots: predsdata,
                                  isCurved: true,
                                  barWidth: 3,
                                  gradient:
                                      LinearGradient(colors: gradientColors2),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: gradientColors2
                                          .map((color) =>
                                              color.withOpacity(0.06))
                                          .toList(),
                                    ),
                                  ),
                                )
                              ],
                              titlesData: FlTitlesData(
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                leftTitles: AxisTitles(sideTitles: leftTitles),
                                bottomTitles: AxisTitles(
                                  sideTitles: bottomTitles,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Market data',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('High'),
                                Text(
                                  '\$080770',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Low'),
                                Text(
                                  '\$87825734',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Volume'),
                                Text(
                                  '\$54156545',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Circulating supply'),
                                Text(
                                  '12,54481,5184',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
