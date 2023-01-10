import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late Response response;
  Dio dio = Dio();

  bool error = false; //for error status
  bool loading = false; //for data featching status
  String errmsg = ""; //to assing any error message from API/runtime
  var apidata; //for decoded JSON data
  var apidata2; //for decoded JSON data

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "can not lauch url";
    }
  }

  @override
  void initState() {
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
    return loading
        ? Center(
            child: Image.asset(
              'assets/images/loading.png',
              fit: BoxFit.fitWidth,
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.width * 1.65,
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
                  height: 30,
                  alignment: Alignment.center,
                  // padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Row(
                      children: apidata2.map<Widget>(
                        (percentage) {
                          return Row(
                            children: [
                              Text(
                                'positive: ' +
                                    percentage['positive'].toString() +
                                    '% ',
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'negative: ' +
                                    percentage['negative'].toString() +
                                    '% ',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'neutral: ' +
                                    percentage['neutral'].toString() +
                                    '% ',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: apidata.map<Widget>(
                          (news) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: news["sentiment"] == "positive"
                                          ? const BorderSide(
                                              color: Colors.green, width: 3)
                                          : news["sentiment"] == "negative"
                                              ? const BorderSide(
                                                  color: Colors.red, width: 3)
                                              : const BorderSide(
                                                  color: Colors.grey, width: 3),
                                    ))),
                                onPressed: () async {
                                  _launchURL(news['url']);
                                },
                                child: ListTile(
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
                  ),
                ),
              ],
            ),
          );
  }
}
