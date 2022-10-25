import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/crypto_item.dart';
import 'package:http/http.dart' as http;

class CryptoController with ChangeNotifier {
  final url = 'http://10.0.2.2:5000/crypto';
  Future<void> getCryptoData(String cryptoName) async {
    var response;
    try {
      response = await http.get(Uri.parse('$url/$cryptoName'));
      Future<List> fetchPrice() async {
        List<double> price = [];
        for (var i = 0; i < 76; i++) {
          price.add(jsonDecode(response.body)[i]['price'] as double);
        }
        print(price);
        return price;
      }

      Future<List> fetchPreds() async {
        List<double> preds = [];
        for (var i = 0; i < 76; i++) {
          preds.add(jsonDecode(response.body)[i]['prediction_price'] as double);
        }
        print(preds);
        return preds;
      }

      Future<List> fetchNum() async {
        List<int> num = [];
        for (var i = 0; i < 76; i++) {
          num.add(jsonDecode(response.body)[i]['num'] as int);
        }
        print(num);
        return num;
      }

      fetchPrice();
      fetchPreds();
      fetchNum();
      // print(price);
      print('done connect');
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
