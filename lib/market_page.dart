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
    const Color(0xfffe036a),
  ];
  final List<Color> gradientColors = [
    const Color(0xff8cfb69),
    const Color(0xff8cfb69),
  ];
  final List<Color> gradientColors3 = [
    const Color(0xff8cfb69),
    Color(0xff03045e)
  ];
  final List<Color> gradientColors4 = [
    const Color(0xfffe036a),
    Color(0xff03045e)
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
        return FlSpot(index.toDouble(), value);
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
                child: Text(
                  DateFormat('dd MMM').format(DateTime.now()),
                  style: TextStyle(color: Colors.white),
                ));

          case 35:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(
                DateFormat('dd MMM')
                    .format(DateTime.now().subtract(const Duration(days: 5))),
                style: TextStyle(color: Colors.white),
              ),
            );
          case 30:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(
                DateFormat('dd MMM')
                    .format(DateTime.now().subtract(const Duration(days: 10))),
                style: TextStyle(color: Colors.white),
              ),
            );
          case 25:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(
                DateFormat('dd MMM')
                    .format(DateTime.now().subtract(const Duration(days: 15))),
                style: TextStyle(color: Colors.white),
              ),
            );
          case 20:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(
                DateFormat('dd MMM')
                    .format(DateTime.now().subtract(const Duration(days: 20))),
                style: TextStyle(color: Colors.white),
              ),
            );
          case 15:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(
                DateFormat('dd MMM')
                    .format(DateTime.now().subtract(const Duration(days: 25))),
                style: TextStyle(color: Colors.white),
              ),
            );
          case 10:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(
                DateFormat('dd MMM')
                    .format(DateTime.now().subtract(const Duration(days: 30))),
                style: TextStyle(color: Colors.white),
              ),
            );
          case 5:
            return Transform.rotate(
              alignment: Alignment.center,
              angle: -60 * math.pi / 180,
              child: Text(
                DateFormat('dd MMM')
                    .format(DateTime.now().subtract(const Duration(days: 35))),
                style: TextStyle(color: Colors.white),
              ),
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
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                  colors: [Color(0xff00b4d8), Color(0xff03045e)],
                  center: Alignment.topLeft,
                  radius: 0.8,
                )),
                child: SafeArea(
                  child: Expanded(
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
                                  width: 10,
                                ),
                                SizedBox(
                                  child: Text(
                                    widget.cryptoname,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   height: 30,
                        //   child: const Center(
                        //     child: Text(
                        //       'Prediction',
                        //       style:
                        //           TextStyle(color: Colors.white, fontSize: 20),
                        //     ),
                        //   ),
                        //   decoration: const BoxDecoration(color: Colors.green),
                        // ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Current price',
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            '\$' + current,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: FutureBuilder<dynamic>(
                                          future: prediction(widget.cryptoname),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04,
                                                  decoration: BoxDecoration(
                                                    gradient: bgGradient(
                                                        snapshot.data
                                                            .toString()),
                                                    border: Border.all(
                                                        color:
                                                            Colors.transparent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: boxShadow(
                                                        snapshot.data
                                                            .toString()),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    snapshot.data.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ));
                                              ;
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }
                                            return const Text("");
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .5,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Color(0xff03045e),
                                      border:
                                          Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(
                                            -3.0,
                                            -3.0,
                                          ),
                                          blurRadius: 5.0,
                                          spreadRadius: 0.8,
                                        ),
                                        BoxShadow(
                                          color: Color(0xff0077b6),
                                          offset: Offset(
                                            3.0,
                                            3.0,
                                          ),
                                          blurRadius: 5.0,
                                          spreadRadius: 0.8,
                                        ),
                                      ],
                                    ),
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 30),
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .3,
                                    child: LineChart(
                                      LineChartData(
                                        minX: 0,
                                        maxX: 40,
                                        minY: minimumpreds < minimumprice
                                            ? minimumpreds -
                                                (minimumpreds * (2 / 100))
                                            : minimumprice -
                                                (minimumprice * (2 / 100)),
                                        // maxY: maximumpreds > maximumprice
                                        //     ? maximumpreds + (maximumpreds * (2 / 100))
                                        //     : minimumprice + (maximumprice * (2 / 100)),
                                        gridData: FlGridData(
                                          verticalInterval: 5,
                                          horizontalInterval: 50,
                                          drawHorizontalLine: true,
                                          show: true,
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
                                              gradient: LinearGradient(
                                                  colors: gradientColors),
                                              belowBarData: BarAreaData(
                                                show: true,
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: gradientColors3
                                                      .map(
                                                        (color) => color
                                                            .withOpacity(0.5),
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
                                            gradient: LinearGradient(
                                                colors: gradientColors2),
                                            // belowBarData: BarAreaData(
                                            //   show: true,
                                            //   gradient: LinearGradient(
                                            //     begin: Alignment.topCenter,
                                            //     end: Alignment.bottomCenter,
                                            //     colors: gradientColors4
                                            //         .map((color) =>
                                            //             color.withOpacity(1))
                                            //         .toList(),
                                            //   ),
                                            // ),
                                          )
                                        ],
                                        titlesData: FlTitlesData(
                                          rightTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                  showTitles: false)),
                                          topTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                  showTitles: false)),
                                          leftTitles: AxisTitles(
                                              sideTitles: leftTitles),
                                          bottomTitles: AxisTitles(
                                            sideTitles: bottomTitles,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    'Market data',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'High',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '\$' + apidata['data']['high'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Low',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            '\$' + apidata['data']['low'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Volume',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '\$' +
                                                  double.parse(apidata['data']
                                                          ['vol'])
                                                      .toStringAsFixed(3),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Average',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '\$' +
                                                  double.parse(apidata['data']
                                                          ['averagePrice'])
                                                      .toStringAsFixed(3),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),
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
                      ],
                    ),
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

  LinearGradient bgGradient(String name) {
    return name == 'Buy'
        ? const LinearGradient(
            colors: [Color(0xff00917c), Color(0xff00917c)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
        : const LinearGradient(
            colors: [Color(0xffb51314), Color(0xffb51314)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          );
  }

  List<BoxShadow> boxShadow(String name) {
    return name == 'Sell'
        ? const [
            BoxShadow(
              color: Color.fromARGB(255, 255, 0, 0),
              offset: Offset(
                3.0,
                3.0,
              ),
              blurRadius: 8.0,
              spreadRadius: 0.8,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(
                -3.0,
                -3.0,
              ),
              blurRadius: 8.0,
              spreadRadius: 0.8,
            ),
          ]
        : const [
            BoxShadow(
              color: Colors.white,
              offset: Offset(
                -3.0,
                -3.0,
              ),
              blurRadius: 8.0,
              spreadRadius: 0.8,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 0, 255, 110),
              offset: Offset(
                3.0,
                3.0,
              ),
              blurRadius: 8.0,
              spreadRadius: 0.8,
            ),
          ];
  }
}
