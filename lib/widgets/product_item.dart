import 'package:flutter/material.dart';
import 'package:myshop2/models/product.dart';
import 'package:myshop2/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
          child: GridTile(
        child: GestureDetector(child: Image.network(product.imageUrl, fit: BoxFit.contain), onTap: () {
          Navigator.of(context).pushNamed(ProductDetailScreen.ROUTE, arguments: product);
        },),
        header: GridTileBar(title: Text(product.title, textAlign: TextAlign.center, style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)), backgroundColor: Color.fromARGB(100, 0, 0, 0)),
        footer: GridTileBar(title: Text("€ " + product.price.toString(), textAlign: TextAlign.center), backgroundColor: Color.fromARGB(180, 0, 0, 0), 
          leading: IconButton(icon: Icon(Icons.favorite_border), onPressed: () {  }, color: Theme.of(context).accentColor,), 
          trailing: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {  }, color: Theme.of(context).accentColor),
      )),
    );
  }
}
