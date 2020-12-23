import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String _id;
  final double _price;
  final String _title;
  final int _quantity;

  CartItem(this._id, this._price, this._title, this._quantity);

  @override
  Widget build(BuildContext context) {
    return Card(margin: EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(child: Text("€${this._price}", style: TextStyle(fontSize: 12),), radius: 40,),
          title: this._quantity == 1? Text(this._title) : Text(this._title + " (x" + this._quantity.toString() + ")"),
          subtitle: Text("Total: €${this._price * this._quantity}"),),));
  }
}