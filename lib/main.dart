import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/pro_detail_screen.dart';
import 'package:shop/screens/product_over_screen.dart';
import 'package:shop/screens/splash_screen.dart';
import './provider/orders.dart';
import './screens/cart_screen.dart';
import './provider/auth.dart';
import './provider/prod_provider.dart';
import './provider/cart.dart';
import './screens/orders_screen.dart';
import './screens/user_prod_screen.dart';
import './screens/edit_prod.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        //in order to recieve the token
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(
            "",
            [],
            "",
          ),
          //providing the instance to all child widgets
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
            auth.userId,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders("", "", []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'My Shop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverView()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapShot) =>
                      authResultSnapShot.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
