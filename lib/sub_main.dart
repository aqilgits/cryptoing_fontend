import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cryptoingfontend/controller/crypto_controller.dart';
import 'package:cryptoingfontend/market_page.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  List<FlSpot> BTC = [];
  List<FlSpot> ETH = [];
  List<FlSpot> XRP = [];
  List<FlSpot> ADA = [];
  List<FlSpot> DOGE = [];
  List crypto = ['Bitcoin', 'Ethereum', 'Ripple', 'Cardanp', 'Dogecoin'];
  late Response response;
  Dio dio = Dio();
  late Future prices;
  late Future preds;
  bool error = false;
  bool loading = false;
  String errmsg = "";
  var apidata;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "can not lauch url";
    }
  }

  final List<Color> gradientColors = [
    const Color(0xff8cfb69),
    const Color(0xff26bbac),
  ];
  final List<Color> gradientColors2 = [
    const Color(0xff8cfb69),
    const Color(0xff03045e)
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

    String url = "http://10.0.2.2:5000/news";
    Response response = await dio.get(url);
    // for (var crypto in crypspot) {
    apidata = response.data; //get JSON decoded data from response
    prices = CryptoController().getCryptoPrice('BTC');
    dynamic valuepricebtc = await prices;

    for (int i = 35; i < valuepricebtc.length; i++) {
      BTC = List.generate(40, (index) {
        double value = (valuepricebtc[index + 35] * 10000).round() / 10000;
        return FlSpot(index.toDouble(), value);
      });
    }
    prices = CryptoController().getCryptoPrice('ETH');
    dynamic valuepriceeth = await prices;
    for (int i = 35; i < valuepriceeth.length; i++) {
      ETH = List.generate(40, (index) {
        double value = (valuepriceeth[index + 35] * 10000).round() / 10000;
        return FlSpot(index.toDouble(), value);
      });
    }
    prices = CryptoController().getCryptoPrice('XRP');
    dynamic valuepricexrp = await prices;
    for (int i = 35; i < valuepricexrp.length; i++) {
      XRP = List.generate(40, (index) {
        double value = (valuepricexrp[index + 35] * 10000).round() / 10000;
        return FlSpot(index.toDouble(), value);
      });
    }
    prices = CryptoController().getCryptoPrice('ADA');
    dynamic valuepriceada = await prices;
    for (int i = 35; i < valuepriceada.length; i++) {
      ADA = List.generate(40, (index) {
        double value = (valuepriceada[index + 35] * 10000).round() / 10000;
        return FlSpot(index.toDouble(), value);
      });
    }
    prices = CryptoController().getCryptoPrice('DOGE');
    dynamic valuepricedoge = await prices;
    for (int i = 35; i < valuepricedoge.length; i++) {
      DOGE = List.generate(40, (index) {
        double value = (valuepricedoge[index + 35] * 10000).round() / 10000;
        return FlSpot(index.toDouble(), value);
      });
    }

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonstyle = ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
    );
    return loading
        ? Center(
            child: Image.asset(
              'assets/images/loading.png',
              fit: BoxFit.fitWidth,
            ),
          )
        : Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Dashboard',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          height: double.infinity,
                        ),
                        items: [BTC, ETH, XRP, ADA, DOGE].map((i) {
                          crypto = [];
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10.0),
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      color: Color(0xff03045e),
                                      borderRadius: BorderRadius.circular(15),
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
                                      image: i == BTC
                                          ? const DecorationImage(
                                              opacity: 0.2,
                                              alignment: Alignment.centerRight,
                                              image: AssetImage(
                                                'assets/images/BTC.png',
                                              ))
                                          : i == ETH
                                              ? const DecorationImage(
                                                  opacity: 0.2,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  image: AssetImage(
                                                    'assets/images/ETH.png',
                                                  ))
                                              : i == ADA
                                                  ? const DecorationImage(
                                                      opacity: 0.2,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      image: AssetImage(
                                                        'assets/images/ADA.png',
                                                      ))
                                                  : i == XRP
                                                      ? const DecorationImage(
                                                          opacity: 0.2,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          image: AssetImage(
                                                            'assets/images/XRP.png',
                                                          ))
                                                      : const DecorationImage(
                                                          opacity: 0.2,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          image: AssetImage(
                                                            'assets/images/DOGE.png',
                                                          ))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          i == BTC
                                              ? Image.asset(
                                                  'assets/images/BTC.png',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03,
                                                )
                                              : i == ETH
                                                  ? Image.asset(
                                                      'assets/images/ETH.png',
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.03,
                                                    )
                                                  : i == XRP
                                                      ? Image.asset(
                                                          'assets/images/XRP.png',
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.03,
                                                        )
                                                      : i == ADA
                                                          ? Image.asset(
                                                              'assets/images/ADA.png',
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.03,
                                                            )
                                                          : Image.asset(
                                                              'assets/images/DOGE.png',
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.03,
                                                            ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            i == BTC
                                                ? 'Bitcoin'
                                                : i == ETH
                                                    ? 'Ethereum'
                                                    : i == XRP
                                                        ? 'Ripple'
                                                        : i == ADA
                                                            ? 'Cardano'
                                                            : 'Dogecoin',
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .7,
                                          alignment: Alignment.topLeft,
                                          child: FutureBuilder<dynamic>(
                                            future: cryptocurrent(
                                              i == BTC
                                                  ? 'BTC'
                                                  : i == ETH
                                                      ? 'ETH'
                                                      : i == XRP
                                                          ? 'XRP'
                                                          : i == ADA
                                                              ? 'ADA'
                                                              : 'DOGE',
                                            ),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  '\$' +
                                                      snapshot.data
                                                          .toStringAsFixed(3),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white70),
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              }
                                              return const Text("");
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: LineChart(
                                            LineChartData(
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
                                                LineChartBarData(
                                                    dotData: FlDotData(
                                                      show: false,
                                                    ),
                                                    spots: i,
                                                    isCurved: true,
                                                    barWidth: 2,
                                                    gradient: LinearGradient(
                                                        colors: gradientColors),
                                                    belowBarData: BarAreaData(
                                                      show: true,
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: gradientColors2
                                                            .map(
                                                              (color) => color
                                                                  .withOpacity(
                                                                      1),
                                                            )
                                                            .toList(),
                                                      ),
                                                    )),
                                              ],
                                              titlesData: FlTitlesData(
                                                rightTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                leftTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Coin",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      "Recommendation",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white30))),
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/BTC.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "BTC",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              " Bitcoin",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                        FutureBuilder<dynamic>(
                                          future: cryptocurrent("BTC"),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                '\$' +
                                                    snapshot.data
                                                        .toStringAsFixed(3),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white70),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }
                                            return const Text("");
                                          },
                                        ),
                                      ],
                                    ),
                                    FutureBuilder<dynamic>(
                                      future: prediction('BTC'),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              decoration: BoxDecoration(
                                                gradient: bgGradient(
                                                    snapshot.data.toString()),
                                                border: Border.all(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: boxShadow(
                                                    snapshot.data.toString()),
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
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        return const Text("");
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const Market("BTC", "bitcoin")));
                          },
                          style: buttonstyle,
                        ),
                        height: 80,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white30))),
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/ETH.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "ETH",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              " Ethereum",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                        FutureBuilder<dynamic>(
                                          future: cryptocurrent("ETH"),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                '\$' +
                                                    snapshot.data
                                                        .toStringAsFixed(3),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white70),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }
                                            return const Text("");
                                          },
                                        ),
                                      ],
                                    ),
                                    FutureBuilder<dynamic>(
                                      future: prediction('ETH'),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              decoration: BoxDecoration(
                                                gradient: bgGradient(
                                                    snapshot.data.toString()),
                                                border: Border.all(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: boxShadow(
                                                    snapshot.data.toString()),
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
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        return Text("");
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const Market("ETH", "ethereum")));
                          },
                          style: buttonstyle,
                        ),
                        height: 80,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white30))),
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/XRP.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "XRP",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              " Ripple",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                        FutureBuilder<dynamic>(
                                          future: cryptocurrent("XRP"),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                '\$' +
                                                    snapshot.data
                                                        .toStringAsFixed(3),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white70),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }
                                            return const Text("");
                                          },
                                        ),
                                      ],
                                    ),
                                    FutureBuilder<dynamic>(
                                      future: prediction('XRP'),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              decoration: BoxDecoration(
                                                gradient: bgGradient(
                                                    snapshot.data.toString()),
                                                border: Border.all(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: boxShadow(
                                                    snapshot.data.toString()),
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
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        return const Text("");
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const Market("XRP", "xrp")));
                          },
                          style: buttonstyle,
                        ),
                        height: 80,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white30))),
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/ADA.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "ADA",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              " Cardano",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                        FutureBuilder<dynamic>(
                                          future: cryptocurrent("ADA"),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                '\$' +
                                                    snapshot.data
                                                        .toStringAsFixed(3),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white70),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }
                                            return const Text("");
                                          },
                                        ),
                                      ],
                                    ),
                                    FutureBuilder<dynamic>(
                                      future: prediction('ADA'),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              decoration: BoxDecoration(
                                                gradient: bgGradient(
                                                    snapshot.data.toString()),
                                                border: Border.all(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: boxShadow(
                                                    snapshot.data.toString()),
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
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        return const Text("");
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const Market("ADA", "cardano")));
                          },
                          style: buttonstyle,
                        ),
                        height: 80,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white30))),
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/DOGE.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "DOGE",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              " Dogecoin",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                        FutureBuilder<dynamic>(
                                          future: cryptocurrent("DOGE"),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                '\$' +
                                                    snapshot.data
                                                        .toStringAsFixed(3),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white70),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }
                                            return const Text("");
                                          },
                                        ),
                                      ],
                                    ),
                                    FutureBuilder<dynamic>(
                                      future: prediction('DOGE'),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              decoration: BoxDecoration(
                                                gradient: bgGradient(
                                                    snapshot.data.toString()),
                                                border: Border.all(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: boxShadow(
                                                    snapshot.data.toString()),
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
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        return const Text("");
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          onPressed: () async {
                            Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const Market("DOGE", "dogecoin")));
                          },
                          style: buttonstyle,
                        ),
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          );
  }

  prediction(String name) async {
    preds = CryptoController().getCryptoPreds(name);

    dynamic valuepreds = await preds;
    prices = CryptoController().getCryptoPrice(name);
    dynamic valueprice = await prices;
    if (valueprice[74] < valuepreds[74]) {
      return "Buy";
    } else {
      return "Sell";
    }
  }

  cryptocurrent(String name) async {
    prices = CryptoController().getCryptoPrice(name);
    dynamic valueprice = await prices;
    return valueprice[74];
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
