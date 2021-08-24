import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshop2/providers/product.dart';
import 'package:myshop2/providers/products_provider.dart';
import 'package:myshop2/widgets/product_item.dart';
import 'package:provider/provider.dart';

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
  final _form = GlobalKey<FormState>();
  var _newProd = Product(
    id: null,
    description: "",
    imageUrl: "",
    price: 0.0,
    title: "",
    isFavorite: false,
  );

  var _initValues = {
    "id": "",
    "description": "",
    "imageUrl": "",
    "price": "0",
    "title": "",
    "isFavorite": false,
  };

  bool _isInit = true;

  @override
  void initState() {
    _imageURLFocusNode.addListener(_updateImageURL);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _newProd = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _initValues = {
          "id": _newProd.id,
          "description": _newProd.description,
          "imageUrl": _newProd.imageUrl,
          "price": _newProd.price.toString(),
          "title": _newProd.title,
          "isFavorite": _newProd.isFavorite,
        };
        _imageURLController.text = _newProd.imageUrl;
      }
      _isInit = false;
    }
  }

  void _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus && (_imageURLController.text.length > 0)) {
      if (_form.currentState.validate()) {
        setState(() {});
      }
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

  void _saveForm() {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      if (_newProd.id != null) {
        Provider.of<ProductsProvider>(context, listen: false)
            .updatePruduct(_newProd.id, _newProd);
      } else {
        Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_newProd);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues["title"],
                decoration: InputDecoration(
                    labelText: "Title",
                    errorStyle: TextStyle(color: Colors.red)),
                textInputAction: TextInputAction.next,
                // onFieldSubmitted: (value) {
                //   FocusScope.of(context).requestFocus(_priceFocusNode);
                // },
                validator: (value) {
                  return value.length > 3 ? null : "At least 3 characters";
                },
                onSaved: (newValue) {
                  _newProd = Product(
                      title: newValue,
                      description: _newProd.description,
                      id: _newProd.id,
                      imageUrl: _newProd.imageUrl,
                      price: _newProd.price,
                      isFavorite: _newProd.isFavorite);
                },
              ),
              TextFormField(
                initialValue: _initValues["price"],
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                // focusNode: _priceFocusNode,
                // onFieldSubmitted: (value) {
                //   FocusScope.of(context).requestFocus(_descriptionFocusNode);
                // },
                validator: (value) {
                  double tmp = double.tryParse(value);
                  return tmp == null ? "Wrong price value" : null;
                },
                onSaved: (newValue) {
                  _newProd = Product(
                      title: _newProd.title,
                      description: _newProd.description,
                      id: _newProd.id,
                      imageUrl: _newProd.imageUrl,
                      price: double.parse(newValue),
                      isFavorite: _newProd.isFavorite);
                },
              ),
              TextFormField(
                initialValue: _initValues["description"],
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                // focusNode: _descriptionFocusNode,
                validator: (value) {
                  return value.isEmpty
                      ? "Enter a description"
                      : value.length > 10
                          ? null
                          : "Minimum length 10 characters";
                },
                onSaved: (newValue) {
                  _newProd = Product(
                      title: _newProd.title,
                      description: newValue,
                      id: _newProd.id,
                      imageUrl: _newProd.imageUrl,
                      price: _newProd.price,
                      isFavorite: _newProd.isFavorite);
                },
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
                      // initialValue: _initValues["imageUrl"],
                      decoration: InputDecoration(labelText: "Image URL"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageURLController,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      focusNode: _imageURLFocusNode,
                      onFieldSubmitted: (value) {
                        _saveForm();
                      },
                      validator: (value) {
                        RegExp regExp = RegExp(
                            r"(http|ftp|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?");
                        if (!regExp.hasMatch(value)) {
                          return "Invalida URL";
                        }
                        if (!value.toUpperCase().endsWith("JPG") &&
                            !value.toUpperCase().endsWith("PNG") &&
                            !value.toUpperCase().endsWith("JPEG")) {
                          return "Must be an image";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _newProd = Product(
                            title: _newProd.title,
                            description: _newProd.description,
                            id: _newProd.id,
                            imageUrl: newValue,
                            price: _newProd.price,
                            isFavorite: _newProd.isFavorite);
                      },
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
