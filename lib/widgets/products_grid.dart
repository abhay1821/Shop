import 'package:flutter/material.dart';
import 'package:shop/provider/prod_provider.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;
  ProductsGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
    //direct communi behind the scenes due to
    // provider only productsgrid widget will be rebuilt
    //so the parent productoverview will not be rebuilt
    final productsData = Provider.of<Products>(context);
    final products = showFav?productsData.favouriteItems: productsData.items;
    return GridView.builder(
      //no of columns
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        //it will return sngle product & with itembulder wil buld al the prdcts
        // create: (c)=>products[index],
        value: products[index],
        child: ProductItem(
            // products[index].id,
            // products[index].title,
            // products[index].imageUrl,
            ),
      ),
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
    );
  }
}
