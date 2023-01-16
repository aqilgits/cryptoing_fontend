import 'dart:math' as math;
import 'dart:math';
import 'package:dio/dio.dart';
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
  double maximumprice = 0.0;
  double minimumprice = 0.0;
  double maximumpreds = 0.0;
  double minimumpreds = 0.0;
  late Future prices;
  late Future preds;
  var apidata;
  Dio dio = Dio();
  final List<Color> gradientColors2 = [
    const Color(0xfffe036a),
    const Color(0xff958093),
  ];
  final List<Color> gradientColors = [
    const Color(0xff8cfb69),
    const Color(0xff26bbac),
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
      double value = (valueprice[74] * 10000).round() / 10000;
      maxi = valueprice.cast<double>();

      print(maximumprice);
      current = value.toString();
      pricedata = List.generate(40, (index) {
        double value = (valueprice[index + 35] * 10000).round() / 10000;
        maximumprice = maxi.getRange(35, 75).reduce(max);
        minimumprice = maxi.getRange(35, 75).reduce(min);
        return FlSpot(index.toDouble(), value);
      });
    }
    for (int i = 35; i < valuepreds.length; i++) {
      predsdata = List.generate(40, (index) {
        double value = (valuepreds[index + 35] * 10000).round() / 10000;
        maxi = valuepreds.cast<double>();
        maximumpreds = maxi.getRange(35, 75).reduce(max);
        minimumpreds = maxi.getRange(35, 75).reduce(min);
        print(maximumpreds);
        return FlSpot(index.toDouble() + 1, value);
      });
    }

    String url = 'https://api.kucoin.com/api/v1/market/stats?symbol=' +
        widget.cryptoname +
        '-USDT';
    Response response = await dio.get(url);
    apidata = response.data;
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
                alignment: Alignment.center,
                angle: -60 * math.pi / 180,
                child: Text(DateFormat('dd MMM').format(DateTime.now())));

          case 35:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd MMM')
                  .format(DateTime.now().subtract(const Duration(days: 5)))),
            );
          case 30:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd MMM')
                  .format(DateTime.now().subtract(const Duration(days: 10)))),
            );
          case 25:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd MMM')
                  .format(DateTime.now().subtract(const Duration(days: 15)))),
            );
          case 20:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd MMM')
                  .format(DateTime.now().subtract(const Duration(days: 20)))),
            );
          case 15:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd MMM')
                  .format(DateTime.now().subtract(const Duration(days: 25)))),
            );
          case 10:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd MMM')
                  .format(DateTime.now().subtract(const Duration(days: 30)))),
            );
          case 5:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(DateFormat('dd MMM')
                  .format(DateTime.now().subtract(const Duration(days: 35)))),
            );
        }
        return const Text('');
      },
    );
  }

  SideTitles get leftTitles {
    return SideTitles(
      reservedSize: 50,
      showTitles: false,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            ),
                            FutureBuilder<dynamic>(
                              future: prediction(widget.cryptoname),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                      margin: const EdgeInsets.all(10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      decoration: BoxDecoration(
                                          color:
                                              snapshot.data.toString() == 'Buy'
                                                  ? Colors.green
                                                  : Colors.red,
                                          border: Border.all(
                                              color: snapshot.data.toString() ==
                                                      'Buy'
                                                  ? Colors.green
                                                  : Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        snapshot.data.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ));
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                return const Text("");
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .6,
                        // padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Container(
                          // margin: const EdgeInsets.all(5),
                          // decoration: BoxDecoration(
                          //   color: Colors.white,
                          //   border: Border.all(color: Colors.transparent),
                          //   borderRadius: BorderRadius.circular(20),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: Colors.grey.withOpacity(0.5),
                          //       spreadRadius: 0,
                          //       blurRadius: 7,
                          //       offset: const Offset(
                          //           0, 5), // changes position of shadow
                          //     ),
                          //   ],
                          // ),
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .5,
                          child: LineChart(
                            LineChartData(
                              minX: 0,
                              maxX: 40,
                              minY: minimumpreds < minimumprice
                                  ? minimumpreds - (minimumpreds * (2 / 100))
                                  : minimumprice - (minimumprice * (2 / 100)),
                              // maxY: maximumpreds > maximumprice
                              //     ? maximumpreds + (maximumpreds * (2 / 100))
                              //     : minimumprice + (maximumprice * (2 / 100)),
                              gridData: FlGridData(
                                show: false,
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: const Border(
                                  top: BorderSide.none,
                                  right: BorderSide.none,
                                  left: BorderSide.none,
                                  bottom: BorderSide.none,
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
                                    barWidth: 2,
                                    gradient:
                                        LinearGradient(colors: gradientColors),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: gradientColors
                                            .map(
                                              (color) => color.withOpacity(0.3),
                                            )
                                            .toList(),
                                      ),
                                    )),
                                LineChartBarData(
                                  dotData: FlDotData(
                                    show: false,
                                  ),
                                  spots: predsdata,
                                  isCurved: true,
                                  barWidth: 2,
                                  gradient:
                                      LinearGradient(colors: gradientColors2),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: gradientColors2
                                          .map(
                                              (color) => color.withOpacity(0.3))
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('High'),
                                  Text(
                                    '\$' + apidata['data']['high'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Low'),
                                Text(
                                  '\$' + apidata['data']['low'],
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
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Volume'),
                                  Text(
                                    '\$' +
                                        double.parse(apidata['data']['vol'])
                                            .toStringAsFixed(3),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Average price'),
                                  Text(
                                    '\$' +
                                        double.parse(
                                                apidata['data']['averagePrice'])
                                            .toStringAsFixed(3),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
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

  prediction(String name) async {
    preds = CryptoController().getCryptoPreds(name);

    dynamic valuepreds = await preds;
    prices = CryptoController().getCryptoPrice(name);
    dynamic valueprice = await prices;
    if (valueprice[74] > valuepreds[74]) {
      return "Buy";
    } else {
      return "Sell";
    }
  }
}
