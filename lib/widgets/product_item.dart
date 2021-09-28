import 'package:flutter/material.dart';
import 'package:myshop2/providers/auth.dart';
import 'package:myshop2/providers/cart.dart';
import 'package:myshop2/providers/product.dart';
import 'package:myshop2/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Consumer<Product>(
        builder: (BuildContext context, product, Widget child) {
          return GridTile(
              child: GestureDetector(
                child: Image.network(product.imageUrl, fit: BoxFit.contain),
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetailScreen.ROUTE,
                      arguments: product.id);
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
                title: Text(
                  "€ " + product.price.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                backgroundColor: Color.fromARGB(180, 0, 0, 0),
                leading: IconButton(
                  icon: product.isFavorite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    product.toggleFavorite(auth.token);
                  },
                  color: product.isFavorite
                      ? Theme.of(context).accentColor
                      : Colors.grey,
                ),
                trailing: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      cart.addItem(product.id, product.title, product.price);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Added: ${product.title}",
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(milliseconds: 2000),
                        action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            cart.removeSingleItem(product.id);
                          },
                        ),
                      ));
                    },
                    color: Theme.of(context).accentColor),
              ));
        },
      ),
    );
  }
}
