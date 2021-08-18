import 'package:flutter/material.dart';
import 'package:myshop2/providers/cart.dart';
import 'package:myshop2/providers/orders.dart';
import 'package:myshop2/screens/cart_screen.dart';
import 'package:myshop2/screens/product_detail_screen.dart';
import 'package:myshop2/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import "./providers/products_provider.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: "Lato"),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.ROUTE: (ctx) => ProductDetailScreen(),
          CartScreen.ROUTE: (ctx) => CartScreen()
        },
      ),
    );
  }
}
