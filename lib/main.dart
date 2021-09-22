import 'package:flutter/material.dart';
import 'package:myshop2/providers/auth.dart';
import 'package:myshop2/providers/cart.dart';
import 'package:myshop2/providers/orders.dart';
import 'package:myshop2/screens/auth_screen.dart';
import 'package:myshop2/screens/cart_screen.dart';
import 'package:myshop2/screens/edit_products_screen.dart';
import 'package:myshop2/screens/orders_screen.dart';
import 'package:myshop2/screens/product_detail_screen.dart';
import 'package:myshop2/screens/products_overview_screen.dart';
import 'package:myshop2/screens/user_products_screen.dart';
import 'package:provider/provider.dart';
import "./providers/products_provider.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        title: 'Shoppissimo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: "Lato"),
        home: AuthScreen(),
        routes: {
          ProductDetailScreen.ROUTE: (ctx) => ProductDetailScreen(),
          CartScreen.ROUTE: (ctx) => CartScreen(),
          OrdersScreen.ROUTE: (ctx) => OrdersScreen(),
          UserProductsScreen.ROUTE: (ctx) => UserProductsScreen(),
          EditProductsScreen.ROUTE: (ctx) => EditProductsScreen(),
          AuthScreen.ROUTE: (ctx) => AuthScreen(),
        },
      ),
    );
  }
}
