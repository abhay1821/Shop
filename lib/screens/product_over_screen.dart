import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/cart.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';

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
            ),
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch ?? Container(),
              value: cart.itemCount,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}
