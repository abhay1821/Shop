import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/product_over_screen.dart';
import '../screens/pro_detail_screen.dart';
import './provider/prod_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //used for only child widget is needed that will noly rebuild
    return ChangeNotifierProvider(
      create: (ctx)=>Products(),
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverView(), 
        routes: {
          ProductDetailScreen.routeName:(ctx)=>ProductDetailScreen(),
        },
      ),
    );
  }
}
