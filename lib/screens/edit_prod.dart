import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../provider/prod_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit/products";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  //for getting acess of the form
  final _form = GlobalKey<FormState>();
  var _editingproduct = Product(
    id: null,
    title: '',
    price: 0.0,
    description: '',
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  @override
  void initState() {
    _imageUrlFocusNode.addListener((_updateImageUrl));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != null) {
        _editingproduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editingproduct.title,
          'description': _editingproduct.description,
          'price': _editingproduct.price.toString(),
          // 'imageUrl': _editingproduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editingproduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  //to avoid the memory leaks
  void dispose() {
    _imageUrlFocusNode.removeListener((_updateImageUrl));
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  //for previwing with key strokes
  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          !_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) {
        return;
      }

      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_editingproduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editingproduct.id!, _editingproduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editingproduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ],
      ),
      //we could also use column with singlechildscrollview
      // instead we use listview without builder
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            //for getting access of the form
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value!.isNotEmpty) {
                      _editingproduct = Product(
                          title: value,
                          description: _editingproduct.description,
                          price: _editingproduct.price,
                          imageUrl: _editingproduct.imageUrl,
                          id: _editingproduct.id,
                          isFavourite: _editingproduct.isFavourite);
                    }
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid No';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please Enter a No greater than Zero';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value!.isNotEmpty) {
                      _editingproduct = Product(
                        title: _editingproduct.title,
                        description: _editingproduct.description,
                        price: double.parse(value),
                        imageUrl: _editingproduct.imageUrl,
                        id: _editingproduct.id,
                        isFavourite: _editingproduct.isFavourite,
                      );
                    }
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a Description';
                    }
                    if (value.length < 10) {
                      return 'Should be atleast 10 Characters Long';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value!.isNotEmpty) {
                      _editingproduct = Product(
                        title: _editingproduct.title,
                        description: value,
                        price: _editingproduct.price,
                        imageUrl: _editingproduct.imageUrl,
                        id: _editingproduct.id,
                        isFavourite: _editingproduct.isFavourite,
                      );
                    }
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter the URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    //textformfield takes as much spce as it gets
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'ImageUrl'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        //for before submitting saving it
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter a Image URl';
                          }
                          if (value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please Enter the valid URl';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            _editingproduct = Product(
                              title: _editingproduct.title,
                              description: _editingproduct.description,
                              price: _editingproduct.price,
                              imageUrl: value,
                              id: _editingproduct.id,
                              isFavourite: _editingproduct.isFavourite,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
