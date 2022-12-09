// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
// import '../models/crypto_item.dart';
import 'package:http/http.dart' as http;

class CryptoController with ChangeNotifier {
  final url = 'http://10.0.2.2:5000/crypto';
  Future<List> getCryptoPrice(String cryptoName) async {
    List price = [];
    dynamic response;
    try {
      response = await http.get(Uri.parse('$url/$cryptoName'));
      Future<List> fetchPrice() async {
        List<double> price = [];
        for (var i = 0; i < 76; i++) {
          price.add(jsonDecode(response.body)[i]['price'] as double);
        }
        // print(price);
        return price;
      }

      price = await fetchPrice();
      // print(price);

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
      response = await http.get(Uri.parse('$url/$cryptoName'));

      Future<List> fetchPreds() async {
        List<double> preds = [];
        for (var i = 0; i < 76; i++) {
          preds.add(jsonDecode(response.body)[i]['prediction_price'] as double);
        }
        return preds;
      }

      preds = await fetchPreds();
      print(preds);

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
      response = await http.get(Uri.parse('$url/$cryptoName'));

      Future<List> fetchNum() async {
        List<int> num = [];
        for (var i = 0; i < 76; i++) {
          num.add(jsonDecode(response.body)[i]['num'] as int);
        }
        print(num);
        return num;
      }

      num = await fetchNum();
      print(num);

      print('done connect');
    } catch (e) {
      print(e);
    }
    return num;
  }
}
