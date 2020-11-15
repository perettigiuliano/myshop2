import 'package:flutter/material.dart';
import 'package:myshop2/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(product.imageUrl, fit: BoxFit.cover),
      footer: GridTileBar(title: Text(product.title, textAlign: TextAlign.center), backgroundColor: Colors.black54, 
      leading: IconButton(icon: Icon(Icons.favorite), onPressed: () {  },), trailing: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {  },),
    ));
  }
}
