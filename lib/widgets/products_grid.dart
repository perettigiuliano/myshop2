import 'package:flutter/material.dart';
import 'package:myshop2/providers/products_provider.dart';

import 'package:myshop2/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    final products = provider.products;
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, index) {
        return ProductItem(products[index]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
