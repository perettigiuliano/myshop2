import 'package:flutter/material.dart';
import 'package:myshop2/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static final String ROUTE = "PRODUCTDETAIL";

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Product;
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
