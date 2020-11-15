import 'package:flutter/material.dart';
import 'package:myshop2/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
          child: GridTile(
        child: Image.network(product.imageUrl, fit: BoxFit.cover),
        footer: GridTileBar(title: Text(product.title, textAlign: TextAlign.center), backgroundColor: Color.fromARGB(180, 0, 0, 0), 
        leading: IconButton(icon: Icon(Icons.favorite_border), onPressed: () {  }, 
        color: Theme.of(context).accentColor,), trailing: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {  }, color: Theme.of(context).accentColor),
      )),
    );
  }
}
