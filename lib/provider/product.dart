import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  
  bool isFavourite;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavStatus(String token,userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://shop-18358-default-rtdb.firebaseio.com/userFav/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        Uri.parse(url),
        body: json.encode(
          isFavourite,
        ),
      );
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
