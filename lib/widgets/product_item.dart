import 'package:flutter/material.dart';
import '../screens/pro_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
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
              arguments: id,
            );
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        //for displaying the title overimage we can also use header
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          //used for icon on the left
          leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
