import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
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
        : Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Sentiment',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      opacity: 0.1,
                      alignment: Alignment.centerLeft,
                      image: NetworkImage(
                          'https://icon-library.com/images/sentiment-icon/sentiment-icon-12.jpg')),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                      child: Expanded(
                        child: SizedBox(
                            height: 100,
                            child: PieChart(PieChartData(sections: [
                              PieChartSectionData(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 255, 26),
                                    width: 2),
                                titleStyle:
                                    const TextStyle(color: Colors.white),
                                color: Colors.green,
                                value: apidata2[0]['positive'].toDouble(),
                                radius: apidata2[0]['positive'].toDouble() <
                                            apidata2[0]['negative']
                                                .toDouble() ||
                                        apidata2[0]['positive'].toDouble() <
                                            apidata2[0]['neutral'].toDouble()
                                    ? 40
                                    : 50,
                                title: apidata2[0]['positive'].toString() + '%',
                              ),
                              PieChartSectionData(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    width: 2),
                                titleStyle:
                                    const TextStyle(color: Colors.white),
                                color: Colors.red,
                                value: apidata2[0]['negative'].toDouble(),
                                radius: apidata2[0]['negative'].toDouble() <
                                            apidata2[0]['positive']
                                                .toDouble() ||
                                        apidata2[0]['negative'].toDouble() <
                                            apidata2[0]['neutral'].toDouble()
                                    ? 40
                                    : 50,
                                title: apidata2[0]['negative'].toString() + '%',
                              ),
                              PieChartSectionData(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 2),
                                titleStyle:
                                    const TextStyle(color: Colors.white),
                                color: Colors.grey,
                                value: apidata2[0]['neutral'].toDouble(),
                                radius: apidata2[0]['neutral'].toDouble() <
                                            apidata2[0]['negative']
                                                .toDouble() ||
                                        apidata2[0]['neutral'].toDouble() <
                                            apidata2[0]['positive'].toDouble()
                                    ? 40
                                    : 50,
                                title: apidata2[0]['neutral'].toString() + '%',
                              ),
                            ]))),
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * .45,
                        child: Row(
                          children: apidata2.map<Widget>(
                            (percentage) {
                              return Row(
                                children: const [
                                  Text(
                                    'positive  ',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'negative  ',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'neutral  ',
                                    style: TextStyle(
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
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'News',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
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
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff03045e),
                                    ),
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
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      image: news["sentiment"] == "positive"
                                          ? const DecorationImage(
                                              opacity: 0.2,
                                              alignment: Alignment.centerRight,
                                              image: AssetImage(
                                                'assets/images/positive.png',
                                              ))
                                          : news["sentiment"] == "natural"
                                              ? const DecorationImage(
                                                  opacity: 0.2,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  image: AssetImage(
                                                    'assets/images/natural.png',
                                                  ))
                                              : const DecorationImage(
                                                  opacity: 0.2,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  image: AssetImage(
                                                    'assets/images/negative.png',
                                                  ))),
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
                                    title: Text(
                                      news["title"],
                                      maxLines: 4,
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    subtitle: Text(
                                      news["sentiment"],
                                      maxLines: 1,
                                      softWrap: false,
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          overflow: TextOverflow.fade),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
