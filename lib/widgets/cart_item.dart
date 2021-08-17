import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String _id;
  final String _productId;
  final double _price;
  final String _title;
  final int _quantity;

  CartItem(this._id, this._productId, this._price, this._title, this._quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(_productId);
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(_id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: FittedBox(
                      child: Text(
                    "€${this._price}",
                  )),
                ),
                radius: 40,
              ),
              title: this._quantity == 1
                  ? Text(this._title)
                  : Text(this._title + " (x" + this._quantity.toString() + ")"),
              subtitle: Text("Total: €${this._price * this._quantity}"),
            ),
          )),
    );
  }
}
