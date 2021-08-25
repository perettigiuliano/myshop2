import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myshop2/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 10.00,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 20.00,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 30.00,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 40.00,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  var showFavoritesOnly = false;

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favorites {
    return _products.where((element) => element.isFavorite).toList();
  }

  addProductFromDetails(String id, String title, String description,
      String imageUrl, double price) {
    Product tmp = new Product(
        id: id,
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl);
    addProduct(tmp);
  }

  void updatePruduct(String id, Product newProd) {
    final index = _products.indexWhere((element) => element.id == id);
    if (index < 0) {
      return;
    }
    _products[index] = newProd;
    notifyListeners();
  }

  Future<void> addProduct(Product prd) {
    final url = Uri.parse(
        "https://shoppissimo-503bb-default-rtdb.europe-west1.firebasedatabase.app/products.json");
    return http
        .post(url,
            body: jsonEncode(
              {
                "title": prd.title,
                "description": prd.description,
                // "id": prd.id,
                "imageUrl": prd.imageUrl,
                "isFavorite": prd.isFavorite,
                "price": prd.price,
              },
            ))
        .then((value) {
      final newPord = Product(
        id: jsonDecode(value.body)["name"],
        title: prd.title,
        description: prd.description,
        price: prd.price,
        imageUrl: prd.imageUrl,
      );
      _products.add(newPord);
      notifyListeners();
    });
  }

  void deleteProduct(String id) {
    this._products.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Product findById(String id) {
    return this._products.firstWhere((element) => element.id == id);
  }
}
