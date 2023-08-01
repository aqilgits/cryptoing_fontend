// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoController with ChangeNotifier {
  late Future prices;
  late Future preds;
  final url =
      'http://ec2-54-169-98-7.ap-southeast-1.compute.amazonaws.com/crypto';
  Future<List> getCryptoPrice(String cryptoName) async {
    List price = [];
    dynamic response;
    try {
      response = await http.get(Uri.parse(
          'http://ec2-54-169-98-7.ap-southeast-1.compute.amazonaws.com/crypto/$cryptoName'));
      Future<List> fetchPrice() async {
        List<double> price = [];
        for (var i = 0; i < 75; i++) {
          price.add(jsonDecode(response.body)[i]['price'] as double);
        }
        return price;
      }

      price = await fetchPrice();

      print('done connect');
    } catch (e) {
      print(e);
    }
    return price;
  }

  Future<List> getCryptoPreds(String cryptoName) async {
    List preds = [];
    dynamic response;
    try {
      response = await http.get(Uri.parse(
          'http://ec2-54-169-98-7.ap-southeast-1.compute.amazonaws.com/crypto/$cryptoName'));

      Future<List> fetchPreds() async {
        List<double> preds = [];
        for (var i = 1; i < 76; i++) {
          preds.add(jsonDecode(response.body)[i]['prediction_price'] as double);
        }
        return preds;
      }

      preds = await fetchPreds();

      print('done connect');
    } catch (e) {
      print(e);
    }
    return preds;
  }

  Future<List> getCryptoNum(String cryptoName) async {
    List num = [];
    dynamic response;
    try {
      response = await http.get(Uri.parse(
          'http://ec2-54-169-98-7.ap-southeast-1.compute.amazonaws.com/crypto/$cryptoName'));

      Future<List> fetchNum() async {
        List<int> num = [];
        for (var i = 0; i < 76; i++) {
          num.add(jsonDecode(response.body)[i]['num'] as int);
        }
        return num;
      }

      num = await fetchNum();

      print('done connect');
    } catch (e) {
      print(e);
    }
    return num;
  }

  prediction(String name) async {
    preds = CryptoController().getCryptoPreds(name);

    dynamic valuepreds = await preds;
    prices = CryptoController().getCryptoPrice(name);
    dynamic valueprice = await prices;
    if (valueprice[44] < valuepreds[74]) {
      print(valuepreds[74]);
      print(valueprice[44]);
      return "Buy";
    } else {
      print(valuepreds[74]);
      print(valueprice[44]);
      return "Sell";
    }
  }

  cryptocurrent(String name) async {
    prices = CryptoController().getCryptoPrice(name);
    dynamic valueprice = await prices;
    return valueprice[44];
  }
}
