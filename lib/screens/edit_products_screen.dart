import 'package:flutter/material.dart';

class EditProductsScreen extends StatefulWidget {
  static const String ROUTE = "/edit-product";

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  // final _priceFocusNode = FocusNode();
  // final _descriptionFocusNode = FocusNode();

  @override
  void dispose() {
    // _priceFocusNode.dispose();
    // _descriptionFocusNode.dispose();
    super.dispose();
  }

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
                // onFieldSubmitted: (value) {
                //   FocusScope.of(context).requestFocus(_priceFocusNode);
                // },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                // focusNode: _priceFocusNode,
                // onFieldSubmitted: (value) {
                //   FocusScope.of(context).requestFocus(_descriptionFocusNode);
                // },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                // focusNode: _descriptionFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
