import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';

import 'package:project1/providers/cart.dart';
import 'package:project1/providers/dio.dart';


class Orders with ChangeNotifier {

  List<Map> _orders = [];
  

  Map _order={};
  Map get order {
    return _order;
  }


  Future<void> addOrder(Map<String, CartItem> cartProduct,String token,int total) async {
  Map<String,String> t={'total':total.toString()};
   
    try {
     cartProduct.forEach((id, orderData) {
      _orders.add(   {
          'color':orderData.color,
          'quantity': orderData.quntity,
          'product_id': orderData.id,
         // 'total':total

        });
    });
  _order.addAll({
    'orderitems':_orders,
  });
    _order['total']=total;

 // _order.addEntries(t);
    print(jsonEncode(_order));
      Dio.Response response = await dio().post('/orders', data: _order, options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      print(response.data.toString());

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
