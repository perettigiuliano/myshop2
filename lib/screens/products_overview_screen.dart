import 'package:flutter/material.dart';
import 'package:myshop2/widgets/products_grid.dart';
class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
      ),
      body: ProductesGrid(),
    );
  }
}