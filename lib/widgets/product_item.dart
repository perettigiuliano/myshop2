import 'package:flutter/material.dart';
import 'package:myshop2/models/product.dart';
import 'package:myshop2/providers/products_provider.dart';
import 'package:myshop2/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final String id;

  ProductItem(this.id);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    final products = provider.products;
    final product = products.firstWhere((element) => element.id == this.id);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            child: Image.network(product.imageUrl, fit: BoxFit.contain),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetailScreen.ROUTE, arguments: this.id);
            },
          ),
          header: GridTileBar(
              title: Text(product.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              backgroundColor: Color.fromARGB(100, 0, 0, 0)),
          footer: GridTileBar(
            title:
                Text("€ " + product.price.toString(), textAlign: TextAlign.center),
            backgroundColor: Color.fromARGB(180, 0, 0, 0),
            leading: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
              color: Colors.grey /* Theme.of(context).accentColor */,
            ),
            trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
                color: Theme.of(context).accentColor),
          )),
    );
  }
}
