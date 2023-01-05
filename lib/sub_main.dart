import 'package:cryptoingfontend/controller/crypto_controller.dart';
import 'package:cryptoingfontend/market_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  List price = [];
  late Response response;
  Dio dio = Dio();
  late Future prices;
  late Future preds;
  bool error = false;
  bool loading = false;
  String errmsg = "";
  var apidata;
  var apidata2;
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
    apidata = response.data; //get JSON decoded data from response

    String url2 = "http://10.0.2.2:5000/news/percentage";

    Response response2 = await dio.get(url2);
    apidata2 = response2.data; //get JSON decoded data from response
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonstyle = ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.black),
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
                decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(
                          0.0,
                          3.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: apidata.getRange(0, 4).map<Widget>(
                    (news) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: news["sentiment"] == "positive"
                                  ? const BorderSide(
                                      color: Colors.green, width: 3)
                                  : news["sentiment"] == "negative"
                                      ? const BorderSide(
                                          color: Colors.red, width: 3)
                                      : const BorderSide(
                                          color: Colors.grey, width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            leading: news["sentiment"] == "positive"
                                ? Image.asset(
                                    'assets/images/positive.png',
                                    fit: BoxFit.fitWidth,
                                  )
                                : news["sentiment"] == "negative"
                                    ? Image.asset(
                                        'assets/images/negative.png',
                                        fit: BoxFit.fitWidth,
                                      )
                                    : Image.asset(
                                        'assets/images/natural.png',
                                        fit: BoxFit.fitWidth,
                                      ),
                            title: Text(news["title"]),
                            subtitle: Text(news["sentiment"]),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(
                          0.0,
                          3.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                height: 370,
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    Container(
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/BTC.png',
                                height: 50,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                color: Colors.black45),
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
                                                  color: Colors.black45),
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
                                                color:
                                                    snapshot.data.toString() ==
                                                            'Buy'
                                                        ? Colors.green
                                                        : Colors.red,
                                                border: Border.all(
                                                    color: snapshot.data
                                                                .toString() ==
                                                            'Buy'
                                                        ? Colors.green
                                                        : Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                                        return Text('Error: ${snapshot.error}');
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Market('BTC')));
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
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/ETH.png',
                                height: 50,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                color: Colors.black45),
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
                                                  color: Colors.black45),
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
                                                color:
                                                    snapshot.data.toString() ==
                                                            'Buy'
                                                        ? Colors.green
                                                        : Colors.red,
                                                border: Border.all(
                                                    color: snapshot.data
                                                                .toString() ==
                                                            'Buy'
                                                        ? Colors.green
                                                        : Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                                        return Text('Error: ${snapshot.error}');
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Market('ETH')));
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
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/XRP.png',
                                height: 50,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                color: Colors.black45),
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
                                                  color: Colors.black45),
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
                                                color:
                                                    snapshot.data.toString() ==
                                                            'Buy'
                                                        ? Colors.green
                                                        : Colors.red,
                                                border: Border.all(
                                                    color: snapshot.data
                                                                .toString() ==
                                                            'Buy'
                                                        ? Colors.green
                                                        : Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                                        return Text('Error: ${snapshot.error}');
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Market('XRP')));
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
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/ADA.png',
                                height: 50,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                color: Colors.black45),
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
                                                  color: Colors.black45),
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
                                                color:
                                                    snapshot.data.toString() ==
                                                            'Buy'
                                                        ? Colors.green
                                                        : Colors.red,
                                                border: Border.all(
                                                    color: snapshot.data
                                                                .toString() ==
                                                            'Buy'
                                                        ? Colors.green
                                                        : Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                                        return Text('Error: ${snapshot.error}');
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Market('ADA')));
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
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/DOGE.png',
                                height: 50,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                color: Colors.black45),
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
                                                  color: Colors.black45),
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
                                                color:
                                                    snapshot.data.toString() ==
                                                            'Buy'
                                                        ? Colors.green
                                                        : Colors.red,
                                                border: Border.all(
                                                    color: snapshot.data
                                                                .toString() ==
                                                            'Buy'
                                                        ? Colors.green
                                                        : Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                                        return Text('Error: ${snapshot.error}');
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Market('DOGE')));
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

  cryptocurrent(String name) async {
    prices = CryptoController().getCryptoPrice(name);
    dynamic valueprice = await prices;
    return valueprice[74];
  }
}
