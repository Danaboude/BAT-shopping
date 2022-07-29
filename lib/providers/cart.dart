import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final int id;
  final int catgoryname;
  final String imgUrl;
  final String title;
  final int quntity;
  final int price;
  final String color;
  CartItem({
    required this.color,
    required this.catgoryname,
    required this.imgUrl,
    required this.id,
    required this.title,
    required this.quntity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imgUrl': imgUrl,
      'title': title,
      'quntity': quntity,
      'price': price,
      'color': color,
      'catgoryname': catgoryname,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      title: map['title'] ?? '',
      quntity: map['quntity']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
      color: map['color'],
      catgoryname: map['catgoryname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartItem(id: $id, catgoryname: $catgoryname, imgUrl: $imgUrl, title: $title, quntity: $quntity, price: $price, color: $color)';
  }
}

class Cart with ChangeNotifier {
  int _total = 0;
  int quntity = 1;
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }
  void setquntity(int quntity1) async {
   quntity=quntity1;
    notifyListeners();
  }
  

 totalafterEditQuntity(int id, int quntity)  {
   print(id);
    _total = 0;
    _items.forEach((key, cartItem) {
      if (id == cartItem.id)
        _total += cartItem.price * quntity;
      else
        _total += cartItem.price * cartItem.quntity;
    });
    notifyListeners();
  }

  Future<void> counttotal() async {
    _total = 0;
    _items.forEach((key, cartItem) {
      _total += cartItem.price * cartItem.quntity;
    });
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    return _total;
  }

  void addItem(int prouctId, int catgoryname, String imgUrl, int price,
      String title, String color, int quntity) async {
    if (_items.containsKey(prouctId)) {
      _items.update(
          prouctId.toString(),
          (existingCartItem) => CartItem(
              color: existingCartItem.color,
              catgoryname: existingCartItem.catgoryname,
              imgUrl: existingCartItem.imgUrl,
              id: existingCartItem.id,
              title: existingCartItem.title,
              quntity: existingCartItem.quntity + quntity,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          prouctId.toString(),
          () => CartItem(
                color: color,
                imgUrl: imgUrl,
                catgoryname: catgoryname,
                id: prouctId,
                title: title,
                quntity: quntity,
                price: price,
              ));
    }
    counttotal();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('itemscart');
    await preferences.setString('itemscart', jsonEncode(_items));
    //print(json.decode(preferences.getString('itemscart')!));

    notifyListeners();
  }

  void fatchandsetcart() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.containsKey('itemscart')) {
        final extractedData = json.decode(preferences.getString('itemscart')!);
        await extractedData.forEach((orderId, orderData) {
          _items.addAll({orderData: CartItem.fromJson(orderData)});
        });
        counttotal();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void removeItem(int productId) async {
    _items.removeWhere(
      (key, value) => value.id == productId,
    );

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('itemscart');
    await preferences.setString('itemscart', jsonEncode(_items));
    counttotal();
    _total = 0;
    _items.forEach((key, cartItem) {
      if (cartItem.id == productId)
        _total -= cartItem.price * cartItem.quntity;
      else
        _total += cartItem.price * cartItem.quntity;
    });

    notifyListeners();
  }

  void removeSingleItem(int productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (items[productId]!.quntity > 1) {
      _items.update(
          productId.toString(),
          (existingCartItem) => CartItem(
              color: existingCartItem.color,
              imgUrl: existingCartItem.imgUrl,
              catgoryname: existingCartItem.catgoryname,
              id: existingCartItem.id,
              title: existingCartItem.title,
              quntity: existingCartItem.quntity - 1,
              price: existingCartItem.price));
    } else {
      items.remove(productId);
    }

    notifyListeners();
  }

  void clear() {
    _items = {};

    notifyListeners();
  }
}
