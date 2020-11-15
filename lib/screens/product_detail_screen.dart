import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myshop2/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static final String ROUTE = "PRODUCTDETAIL";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<ProductsProvider>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
