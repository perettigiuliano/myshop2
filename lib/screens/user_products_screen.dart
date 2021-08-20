import 'package:flutter/material.dart';
import 'package:myshop2/providers/product.dart';
import 'package:myshop2/providers/products_provider.dart';
import 'package:myshop2/screens/edit_products_screen.dart';
import 'package:myshop2/widgets/app_drawer.dart';
import 'package:myshop2/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const String ROUTE = "/user-products";

  @override
  Widget build(BuildContext context) {
    final prods = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.ROUTE);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                UserProductItem(
                    title: prods.products[index].title,
                    imageURL: prods.products[index].imageUrl),
                Divider(),
              ],
            );
          },
          itemCount: prods.products.length,
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
