import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum FiltersOptions {
  favourites,
  All,
}

class ProductsOverView extends StatefulWidget {
  @override
  _ProductsOverViewState createState() => _ProductsOverViewState();
}

class _ProductsOverViewState extends State<ProductsOverView> {
  var _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FiltersOptions selectedValue) {
                setState(() {
                  if (selectedValue == FiltersOptions.favourites) {
                    _showOnlyFavourites = true;
                    // productsContainer.showFavouritesOnly();
                  } else {
                    _showOnlyFavourites = false;
                    // productsContainer.showAll();
                  }
                });
              },
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only favourites'),
                      value: FiltersOptions.favourites,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: FiltersOptions.All,
                    )
                  ],
              icon: Icon(
                Icons.more_vert,
              ))
        ],
      ),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}
