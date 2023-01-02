import 'package:cryptoingfontend/market_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'controller/crypto_controller.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  List price = [];
  // @override
  // void initState() {
  //   super.initState();
  // }
  late Response response;
  Dio dio = Dio();

  bool error = false; //for error status
  bool loading = false; //for data featching status
  String errmsg = ""; //to assing any error message from API/runtime
  var apidata; //for decoded JSON data
  var apidata2; //for decoded JSON data

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
          side: BorderSide(color: Colors.grey),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
    );
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Container(
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                          // children: apidata.map<Widget>(
                          //   (news) {
                          //     return Card(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(20.0),
                          //       ),
                          //       child: ListTile(
                          //         shape: RoundedRectangleBorder(
                          //           side: news["sentiment"] == "positive"
                          //               ? const BorderSide(
                          //                   color: Colors.green, width: 3)
                          //               : news["sentiment"] == "negative"
                          //                   ? const BorderSide(
                          //                       color: Colors.red, width: 3)
                          //                   : const BorderSide(
                          //                       color: Colors.grey, width: 3),
                          //           borderRadius: BorderRadius.circular(20),
                          //         ),
                          //         title: Text(news["title"]),
                          //         subtitle: Text(news["sentiment"]),
                          //       ),
                          //     );
                          //   },
                          // ).toList(),
                          ),
                    ),
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
                                  'assets/images/BTC.png',
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
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/ETH.png',
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
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/XRP.png',
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
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/ADA.png',
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
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/DOGE.png',
                                  height: 50,
                                ),
                              ),
                              const Text(
                                "DOGE",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
            ),
          );
  }
}
