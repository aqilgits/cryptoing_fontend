import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cryptoingfontend/controller/crypto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class Market extends StatefulWidget {
  final String cryptoname;
  const Market(this.cryptoname, {Key? key}) : super(key: key);

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  List<FlSpot> pricedata = [];
  List<FlSpot> predsdata = [];
  List maximum = [];
  double min = 0.0;
  bool loading = false;
  String current = '';
  late Future prices;
  late Future preds; //for data featching status
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a)
  ];
  final List<Color> gradientColors2 = [
    Color.fromARGB(255, 205, 1, 1),
    Color.fromARGB(255, 8, 234, 87)
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
    preds = CryptoController().getCryptoPreds(widget.cryptoname);
    loading = false;
    setState(() {});
  }

  SideTitles get bottomTitles {
    return SideTitles(
      reservedSize: 70,
      showTitles: true,
      getTitlesWidget: (value, meta) {
        // String text = '';
        switch (value.toInt()) {
          case 40:
            return RotatedBox(
                quarterTurns: 3,
                child: Text(DateFormat('dd/MM/yy').format(DateTime.now())));

          case 35:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 5)))),
            );
          case 30:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 10)))),
            );
          case 25:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 15)))),
            );
          case 20:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 20)))),
            );
          case 15:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 25)))),
            );
          case 10:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 30)))),
            );
          case 5:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 35)))),
            );
          case 0:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 40)))),
            );
        }
        return const Text('');
      },
    );
  }

  SideTitles get leftTitles {
    return SideTitles(
      reservedSize: 70,
      showTitles: true,
      getTitlesWidget: (value, meta) {
        // String text = '';
        switch (value.toInt()) {
          case 40:
            return RotatedBox(
                quarterTurns: 3,
                child: Text(DateFormat('dd/MM/yy').format(DateTime.now())));

          case 35:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 5)))),
            );
          case 30:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 10)))),
            );
          case 25:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 15)))),
            );
          case 20:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 20)))),
            );
          case 15:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 25)))),
            );
          case 10:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 30)))),
            );
          case 5:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 35)))),
            );
          case 0:
            return RotatedBox(
              quarterTurns: 3,
              child: Text(DateFormat('dd/MM/yy')
                  .format(DateTime.now().subtract(Duration(days: 40)))),
            );
        }
        return const Text('');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    prices.then((list) {
      double value = (list[74] * 10000).round() / 10000;
      current = value.toString();
      pricedata = List.generate(40, (index) {
        double value = (list[index + 35] * 10000).round() / 10000;
        return FlSpot(index.toDouble(), value);
      });
    });
    preds.then((list) {
      predsdata = List.generate(40, (index) {
        double value = (list[index + 35] * 10000).round() / 10000;
        return FlSpot(index.toDouble() + 1, value);
      });
    });
    String name = ("assets/images/" + widget.cryptoname + ".png");
    return MaterialApp(
      home: Scaffold(
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
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
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(0, 20, 40, 20),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .5,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: false,
                            ),
                            borderData: FlBorderData(show: false),
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
                                          .map(
                                              (color) => color.withOpacity(0.1))
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
                                        .map((color) => color.withOpacity(0.1))
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
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 50,
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: bottomTitles,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
