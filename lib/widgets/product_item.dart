import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../screens/pro_detail_screen.dart';
import '../provider/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    //cliprrect for giving shape to gridtile
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        //for adding on tap on image
        child: GestureDetector(
          onTap: () {
            //WE COULD ALSO USE PUSHNAMED and routename
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => ProductDetailScreen(title),
            //   ),
            // );
            //we havnt used if prodetailscreen require price we cant provide it here
            //so we prefer name route as passing through arguments
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        //for displaying the title overimage we can also use header
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          //used for icon on the left
          leading: IconButton(
            icon: Icon(
              product.isFavourite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              product.toggleFavStatus();
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Provider.of<Cart>(context, listen: false).additem(
                product.id!,
                product.price,
                product.title,
              );
              //for hide current snackbar
              // ignore: deprecated_member_use
              Scaffold.of(context).hideCurrentSnackBar();
              //for the nearest scaffold
              // ignore: deprecated_member_use
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added Item to Cart',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false)
                          .removeSingleItem(product.id!);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
