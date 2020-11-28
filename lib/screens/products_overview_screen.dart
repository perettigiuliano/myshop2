import 'package:flutter/material.dart';
import 'package:myshop2/providers/cart.dart';
import 'package:myshop2/screens/cart_screen.dart';
import 'package:myshop2/widgets/badge.dart';
// import 'package:myshop2/providers/products_provider.dart';
import 'package:myshop2/widgets/products_grid.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

enum FilterOptions { ALL, FAVORITES }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    // final Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: [
          Consumer<Cart>(
            builder: (BuildContext context, cart, Widget child) {
              return Badge(
                value: cart.quantity.toString(),
                child: child,
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.ROUTE);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.FAVORITES) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("All"),
                  value: FilterOptions.ALL,
                ),
                PopupMenuItem(
                  child: Text("Favorites"),
                  value: FilterOptions.FAVORITES,
                )
              ];
            },
          )
        ],
      ),
      body: ProductesGrid(_showOnlyFavorites),
    );
  }
}
