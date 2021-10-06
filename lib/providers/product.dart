import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myshop2/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void _rollbackFavorite(bool oldValue) {
    isFavorite = oldValue;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    var urlUpdate = Uri.parse(
        "https://shoppissimo-503bb-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId/$id.json?auth=$token");
    var tmp = isFavorite;
    this.isFavorite = !this.isFavorite;
    notifyListeners();
    try {
      http.Response response = await http.put(urlUpdate,
          body: jsonEncode(
            isFavorite,
          ));
      if (response.statusCode >= 400) {
        _rollbackFavorite(tmp);
        throw HttpException("Can't change favorite");
      }
    } catch (error) {
      _rollbackFavorite(tmp);
    }
  }
}
