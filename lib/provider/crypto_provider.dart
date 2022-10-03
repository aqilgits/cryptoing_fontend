import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/crypto_item.dart';
import 'package:http/http.dart' as http;

class CryptoProvider with ChangeNotifier {
  List<CryptoItem> _items = [];
  final url = 'http://10.0.2.2:5000/crypto';

  List<CryptoItem> get items {
    return [..._items];
  }

  Future<void> getCryptoData(String cryptoName) async {
    var response;
    try {
      response = await http.get(Uri.parse('$url/$cryptoName'));
      List<dynamic> body = json.decode(response.body);
      _items = body
          .map((e) => CryptoItem(
              id: e['num'],
              predictionPrice: e['prediction_price'],
              price: e['price']))
          .toList();
      print('done connect');
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
