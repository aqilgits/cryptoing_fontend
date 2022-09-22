import 'package:cryptoingfontend/news_page.dart';
import 'package:flutter/material.dart';
import 'package:cryptoingfontend/market_page.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:ionicons/ionicons.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Widget _child;

  @override
  void initState() {
    _child = const MarketPrediction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: _child),
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                icon: Ionicons.newspaper_outline,
                backgroundColor: Colors.green,
                extras: {"label": "news"}),
            FluidNavBarIcon(
                icon: Icons.auto_graph,
                backgroundColor: Colors.green,
                extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Ionicons.help_outline,
                backgroundColor: Colors.green,
                extras: {"label": "help"}),
          ],
          onChange: _handleNavigationChange,
          style: const FluidNavBarStyle(
              iconUnselectedForegroundColor: Colors.white,
              iconSelectedForegroundColor: Colors.white,
              barBackgroundColor: Colors.green),
          scaleFactor: 1.5,
          defaultIndex: 1,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(
      () {
        switch (index) {
          case 0:
            _child = const News();
            break;
          case 1:
            _child = const MarketPrediction();
            break;
          case 2:
            _child = const MarketPrediction();
            break;
        }
        _child = AnimatedSwitcher(
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          duration: const Duration(milliseconds: 500),
          child: _child,
        );
      },
    );
  }
}
