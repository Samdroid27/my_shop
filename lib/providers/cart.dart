import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier{
  
  Map<String , CartItem> _items ={};

  Map<String, CartItem> get items{
    return {..._items};
  }

  int get itemCount{
    return _items.length;
  }
  
  int get itemTotCount{
    int sum=0;
    _items.forEach(((id,ci)=> sum = sum+ ci.quantity));
    return sum;
  }

  double get totalAmount {
    double total =0.0;
    _items.forEach((id,ci)=> total += ci.price * ci.quantity);
    return total;
  }

  void addItem(String productId, double price , String title, int quantity){
    if(_items.containsKey(productId)){
      _items.update(productId, (existCI) => CartItem(
        id: existCI.id,
        title: existCI.title,
        price: existCI.price,
        quantity: existCI.quantity + 1
      ));
    }
    else{
      _items.putIfAbsent(productId,()=> CartItem(
        id: DateTime.now().toString(),
        title: title,
        quantity: quantity,
        price: price
      ));
    }
     notifyListeners();
  }

  void removeItem(String prodId){
    _items.remove(prodId);
    notifyListeners();
  }

  void removeSingleItem(String productId){
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId].quantity > 1){
      _items.update(productId, (existCI)=> CartItem(
        title: existCI.title,
        price: existCI.price,
        id: existCI.id,
        quantity: existCI.quantity-1
      ));
    }
    else{
      _items.remove(productId);
    }
    notifyListeners();
  }

  

  void clearCart(){
    _items.clear();
    notifyListeners();
  }
 
}