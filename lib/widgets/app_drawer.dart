import 'package:flutter/material.dart';
import 'package:myshop2/helpers/custom_route.dart';
import 'package:myshop2/providers/auth.dart';
import 'package:myshop2/screens/orders_screen.dart';
import 'package:myshop2/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Drawer"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed(OrdersScreen.ROUTE);
              Navigator.of(context).pushReplacement(CustomRoute(
                widgetBuilder: (context) => OrdersScreen(),
              ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage products"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.ROUTE);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logOut();
            },
          ),
        ],
      ),
    );
  }
}
