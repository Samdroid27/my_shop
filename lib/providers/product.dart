import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.title,
    this.isFavorite = false
  });
  

  Future<void> toggleFavorite(String token,String userId) async{
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    final url = 'https://flutter-first-project-1e882.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try{
      final response = await http.put(url,body: json.encode(
            isFavorite
          ));
      if(response.statusCode >= 400){
        isFavorite = oldStatus;
      notifyListeners();
      }
      notifyListeners();
    }catch(error){
      isFavorite = oldStatus;
      notifyListeners();
    }
    
  }
}