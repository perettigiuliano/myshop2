import 'package:flutter/widgets.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  int _quantity = 0;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String id, String title, double price) {
    if ((_items != null) && (_items.containsKey(id))) {
      _items.update(
          id,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity + 1,
              price: value.price));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    _quantity += 1;
    notifyListeners();
  }

  void get clear {
    _items.clear();
    _quantity = 0;
    notifyListeners();
  }

  int get quantity {
    return _quantity;
  }

  int get distinctQuantity {
    return _items.length;
  }

  double get total {
    double tot = 0.0;
    _items.forEach((key, value) {
      tot += (value.price * value.quantity);
    });
    return tot;
  }

  void removeItem(String id) {
    _quantity -= 1;
    _items.remove(id);
    notifyListeners();
  }
}
