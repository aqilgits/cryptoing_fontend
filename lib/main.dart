import 'package:flutter/material.dart';
import 'package:cryptoingfontend/market_page.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget? _child;

  @override
  void initState() {
    _child = MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Center(),
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
              icon: Icons.bookmark,
              backgroundColor: Colors.green,
              extras: {"label": "home"}),
          FluidNavBarIcon(
              icon: Icons.auto_graph,
              backgroundColor: Colors.green,
              extras: {"label": "bookmark"}),
          FluidNavBarIcon(
              icon: Icons.help,
              backgroundColor: Colors.green,
              extras: {"label": "partner"}),
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
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = MyHomePage();
          break;
        case 1:
          _child = null;
          break;
        case 2:
          _child = null;
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
