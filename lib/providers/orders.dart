import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:myshop2/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orderItems = [];

  List<OrderItem> get orders {
    return [..._orderItems];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        "https://shoppissimo-503bb-default-rtdb.europe-west1.firebasedatabase.app/orders.json");
    final http.Response response = await http.get(url);
    final List<OrderItem> fetched = [];
    final decodedData = jsonDecode(response.body) as Map<String, dynamic>;
    if (decodedData == null) {
      return null;
    }
    decodedData.forEach((key, value) {
      fetched.add(OrderItem(
        id: key,
        amount: value["amount"],
        products: (value["products"] as List<dynamic>)
            .map((item) => CartItem(
                  id: item["id"],
                  title: item["title"],
                  quantity: item["quantity"],
                  price: item["price"],
                ))
            .toList(),
        dateTime: DateTime.parse(value["dateTime"]),
      ));
    });
    _orderItems = fetched.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> items, double total) async {
    final url = Uri.parse(
        "https://shoppissimo-503bb-default-rtdb.europe-west1.firebasedatabase.app/orders.json");
    final time = DateTime.now();
    try {
      final http.Response value = await http.post(url,
          body: json.encode(
            {
              "amount": total,
              "dateTime": time.toIso8601String(),
              "products": items
                  .map((e) => {
                        "id": e.id,
                        "title": e.title,
                        "price": e.price,
                        "quantity": e.quantity,
                      })
                  .toList(),
            },
          ));
      _orderItems.insert(
          0,
          OrderItem(
              id: jsonDecode(value.body)["name"],
              amount: total,
              products: items,
              dateTime: time));
      notifyListeners();
    } catch (error) {
      print("Can't save cart!!!");
    }
  }
}
