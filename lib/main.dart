import 'package:cryptoingfontend/screen/help.dart';
import 'package:cryptoingfontend/screen/news_page.dart';
import 'package:cryptoingfontend/screen/screenWrapper.dart';
import 'package:flutter/material.dart';
import 'package:cryptoingfontend/screen/sub_main.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'controller/crypto_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
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
          home: ScreenWrapper()),
    );
  }
}
