import 'package:flutter/material.dart';
import 'package:myshop2/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const String ROUTE = "/orders";

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.error != null) {
              // TODO: error handling code
              return null;
            }
            return Consumer<Orders>(builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.orders.length,
                itemBuilder: (context, index) => OrderItem(value.orders[index]),
              );
            });
          }),
      drawer: AppDrawer(),
    );
  }
}
