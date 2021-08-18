import 'package:flutter/foundation.dart';
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

  void addOrder(List<CartItem> items, double total) {
    _orderItems.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: items,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
