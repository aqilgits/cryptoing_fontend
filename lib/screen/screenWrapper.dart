import 'package:cryptoingfontend/main.dart';
import 'package:cryptoingfontend/screen/help.dart';
import 'package:cryptoingfontend/screen/news_page.dart';
import 'package:cryptoingfontend/screen/sub_main.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/scheduler.dart';
import 'package:ionicons/ionicons.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({Key? key}) : super(key: key);

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  late Widget _child;

  @override
  void initState() {
    _child = const Main();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
