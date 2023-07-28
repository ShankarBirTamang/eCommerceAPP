import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartProvider with ChangeNotifier {
  //initialize a variable called _cartBox by getting a box named 'cart_box'
  //from the Hive database.
  final _cartBox = Hive.box('cart_box');

  int _counter = 0;
  List<dynamic> _cart = [];

  int get counter => _counter;
  List<dynamic> get cart => _cart;

  set cart(List<dynamic> newCart) {
    _cart = newCart;
    notifyListeners();
  }

  void increment(int key) {
    final item = _cartBox.get(key);
    item['qty'] = item['qty'] + 1;
    debugPrint('incremented ${item['name']} here with new quantity ${item['qty']}');

    notifyListeners();
  }

  void decrement(int key) {
    final item = _cartBox.get(key);
    if (item['qty'] >= 1) {
      item['qty'] = item['qty'] - 1;
    }
    debugPrint('Decremented ${item['name']} here with new quantity ${item['qty']}');
    notifyListeners();
  }

  //Future function to add items in our cart box
  Future<void> createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  Future<void> deleteCart(int key) async {
    await _cartBox.delete(key);
  }

  getCart() {
    //the code is transforming the data in the cBox map into a new list called cartData,
    //where each element in the list represents an item in the cart
    //with its associated properties.
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes']
      };
    }).toList();

    // Reversing the list , so that the last one added, stays at the top.
    _cart = cartData.reversed.toList();
  }
}
