import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:myshop2/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(symbol: "€");
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("${formatCurrency.format(widget.order.amount)}"),
            subtitle: Text(
                DateFormat("dd/MM/yyyy - hh:mm").format(widget.order.dateTime)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView(
                children: widget.order.products
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            e.title,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text("(x" + e.quantity.toString() + ")"),
                          Text(
                            formatCurrency.format(e.price),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              // height: min(widget.order.products.length * 20.0 + 100.0, 80.0),
              height: widget.order.products.length * 30.0,
            )
        ],
      ),
    );
  }
}
