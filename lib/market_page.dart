import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:ionicons/ionicons.dart';

class MarketPrediction extends StatefulWidget {
  const MarketPrediction({Key? key}) : super(key: key);

  @override
  State<MarketPrediction> createState() => _MarketPredictionState();
}

class _MarketPredictionState extends State<MarketPrediction> {
  Widget? _child;

  @override
  void initState() {
    _child = const MarketPrediction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("hello market page"),
    );
  }
}
