import 'package:cryptoingfontend/provider/crypto_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 20,
        maxY: 10,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 30,
        maxY: 40,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      case 6:
        text = '1m';
        break;
      case 7:
        text = '2m';
        break;
      case 8:
        text = '3m';
        break;
      case 9:
        text = '5m';
        break;
      case 10:
        text = '6m';
        break;
      // case 11:
      //   text = '1m';
      //   break;
      // case 12:
      //   text = '2m';
      //   break;
      // case 13:
      //   text = '3m';
      //   break;
      // case 14:
      //   text = '5m';
      //   break;
      // case 15:
      //   text = '6m';
      //   break;
      // case 16:
      //   text = '1m';
      //   break;
      // case 17:
      //   text = '2m';
      //   break;
      // case 18:
      //   text = '3m';
      //   break;
      // case 19:
      //   text = '5m';
      //   break;
      // case 20:
      //   text = '6m';
      //   break;
      // case 21:
      //   text = '1m';
      //   break;
      // case 22:
      //   text = '2m';
      //   break;
      // case 23:
      //   text = '3m';
      //   break;
      // case 24:
      //   text = '5m';
      //   break;
      // case 25:
      //   text = '6m';
      //   break;
      // case 26:
      //   text = '1m';
      //   break;
      // case 27:
      //   text = '2m';
      //   break;
      // case 28:
      //   text = '3m';
      //   break;
      // case 29:
      //   text = '5m';
      //   break;
      // case 30:
      //   text = '6m';
      //   break;
      // case 31:
      //   text = '1m';
      //   break;
      // case 32:
      //   text = '2m';
      //   break;
      // case 33:
      //   text = '3m';
      //   break;
      // case 34:
      //   text = '5m';
      //   break;
      // case 35:
      //   text = '6m';
      //   break;
      // case 36:
      //   text = '1m';
      //   break;
      // case 37:
      //   text = '2m';
      //   break;
      // case 38:
      //   text = '3m';
      //   break;
      // case 39:
      //   text = '5m';
      //   break;
      // case 40:
      //   text = '6m';
      //   break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('1', style: style);
        break;
      case 4:
        text = const Text('2', style: style);
        break;
      case 6:
        text = const Text('3', style: style);
        break;
      case 8:
        text = const Text('4', style: style);
        break;
      case 10:
        text = const Text('5', style: style);
        break;
      case 12:
        text = const Text('6', style: style);
        break;
      case 14:
        text = const Text('7', style: style);
        break;
      case 16:
        text = const Text('8', style: style);
        break;
      case 18:
        text = const Text('9', style: style);
        break;
      case 20:
        text = const Text('10', style: style);
        break;
      case 22:
        text = const Text('11', style: style);
        break;
      case 24:
        text = const Text('12', style: style);
        break;
      case 26:
        text = const Text('13', style: style);
        break;
      case 28:
        text = const Text('14', style: style);
        break;
      case 30:
        text = const Text('15', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: const Color(0xff4af699),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: const Color(0xffaa4cfc),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: const Color(0x00aa4cfc),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: const Color(0xff27b6fc),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x444af699),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: const Color(0x99aa4cfc),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: const Color(0x33aa4cfc),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x4427b6fc),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
      );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              // gradient: LinearGradient(
              //   colors: [
              //     Color(0xff2c274c),
              //     Color(0xff46426c),
              //   ],
              //   begin: Alignment.bottomCenter,
              //   end: Alignment.topCenter,
              // ),
              border: Border.all(color: Colors.grey),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                        child: _LineChart(isShowingMainData: isShowingMainData),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color:
                        Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      isShowingMainData = !isShowingMainData;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: Provider.of<CryptoProvider>(context, listen: false)
              .getCryptoData('BTC'),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<CryptoProvider>(
                  child: Center(
                    heightFactor: MediaQuery.of(context).size.height * 0.03,
                    child: const Text(
                      'You have no tasks.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  builder: (ctx, cryptoProvider, child) => cryptoProvider
                          .items.isEmpty
                      ? child as Widget
                      : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                              itemCount: cryptoProvider.items.length,
                              itemBuilder: (ctx, i) => Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: ListTile(
                                  tileColor: Colors.black12,
                                  title: Text(
                                      (cryptoProvider.items[i].predictionPrice)
                                          .toString()),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
        )
      ],
    );
  }
}
