import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myshop2/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static final String ROUTE = "PRODUCTDETAIL";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final product =
        Provider.of<ProductsProvider>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "€${product.price}",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
