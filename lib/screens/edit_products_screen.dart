import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductsScreen extends StatefulWidget {
  static const String ROUTE = "/edit-product";

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  // final _priceFocusNode = FocusNode();
  // final _descriptionFocusNode = FocusNode();
  final _imageURLFocusNode = FocusNode();
  final _imageURLController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _imageURLFocusNode.addListener(_updateImageURL);
  }

  void _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // _priceFocusNode.dispose();
    // _descriptionFocusNode.dispose();
    // _descriptionFocusNode.dispose();
    _imageURLFocusNode.dispose();
    _imageURLController.dispose();
    _imageURLFocusNode.removeListener(_updateImageURL);
    _imageURLFocusNode.dispose();
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    )),
                    child: _imageURLController.text.isEmpty
                        ? Text("Enter URL")
                        : FittedBox(
                            child: Image.network(_imageURLController.text),
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Imgae URL"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageURLController,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      focusNode: _imageURLFocusNode,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
