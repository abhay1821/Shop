import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/prod_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import './edit_prod.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/user-products";
  Future _refreshProduct(BuildContext context) async {
    //checkkkkk
    return await Provider.of(context, listen: false).fetchAndSetProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: "");
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      //refresh indicator
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProduct(context),
                    child: Consumer<Products>(
                      builder: (ctx, productData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemBuilder: (_, index) => Column(
                            children: [
                              UserProductItem(
                                productData.items[index].id!,
                                productData.items[index].title,
                                productData.items[index].imageUrl,
                              ),
                              Divider(),
                            ],
                          ),
                          itemCount: productData.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
