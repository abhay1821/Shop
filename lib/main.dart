import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/orders.dart';
import './screens/cart_screen.dart';
import './screens/product_over_screen.dart';
import '../screens/pro_detail_screen.dart';
import './provider/prod_provider.dart';
import './provider/cart.dart';
import './screens/orders_screen.dart';
import './screens/user_prod_screen.dart';
import './screens/edit_prod.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //used for only child widget is needed that will noly rebuild
    //provided at the root level d=so that it can be acessed by all others
    //instead of material app
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //providing the instance to all child widgets
          create: (ctx) => Products(),
          //we r creating new object thatswhy be used create
          // value: Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverView(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
