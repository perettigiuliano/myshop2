import 'package:flutter/material.dart';
import 'package:myshop2/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const String ROUTE = "/orders";
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (context, index) => OrderItem(orders.orders[index]),
      ),
      drawer: AppDrawer(),
    );
  }
}
