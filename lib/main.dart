import 'package:cryptoingfontend/help.dart';
import 'package:cryptoingfontend/news_page.dart';
import 'package:flutter/material.dart';
import 'package:cryptoingfontend/sub_main.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'controller/crypto_controller.dart';

void main() async {
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
    _child = const Main();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: CryptoController(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: Container(
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                  colors: [Color(0xff00b4d8), Color(0xff03045e)],
                  center: Alignment.topLeft,
                  radius: 0.8,
                )),
                child: SafeArea(child: _child)),
            bottomNavigationBar: FluidNavBar(
              icons: [
                FluidNavBarIcon(
                    icon: Ionicons.newspaper_outline,
                    backgroundColor: const Color(0xff0077b6),
                    extras: {"label": "news"}),
                FluidNavBarIcon(
                    icon: Icons.auto_graph,
                    backgroundColor: const Color(0xff0077b6),
                    extras: {"label": "home"}),
                FluidNavBarIcon(
                    icon: Ionicons.help_outline,
                    backgroundColor: const Color(0xff0077b6),
                    extras: {"label": "help"}),
              ],
              onChange: _handleNavigationChange,
              style: const FluidNavBarStyle(
                iconUnselectedForegroundColor: Colors.white,
                iconSelectedForegroundColor: Colors.transparent,
                barBackgroundColor: Color(0xff0077b6),
              ),
              scaleFactor: 1.5,
              defaultIndex: 1,
              itemBuilder: (icon, item) => Semantics(
                label: icon.extras!["label"],
                child: item,
              ),
            ),
          ),
        ));
  }

  void _handleNavigationChange(int index) {
    setState(
      () {
        switch (index) {
          case 0:
            _child = const News();
            break;
          case 1:
            _child = const Main();
            break;
          case 2:
            _child = const Help();
            break;
        }
      },
    );
  }
}
