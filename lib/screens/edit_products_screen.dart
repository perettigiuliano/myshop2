import 'package:flutter/material.dart';

class EditProductsScreen extends StatefulWidget {
  static const String ROUTE = "/edit-product";

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
