import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project1/providers/category.dart';
import 'package:project1/providers/color1.dart';
import 'package:project1/providers/company.dart';
import 'package:project1/providers/product.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:project1/providers/mySlider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio.dart';

class Fatchdata with ChangeNotifier {
  String tokentype = '';

  List<int> _rangeprice = [];
  List<int> get rangeprice => _rangeprice;
  String? _namecomselect;
  String? get namecomselect => _namecomselect;
  List<Company> _comname = [];
  List<Company> get comname => _comname;
  List<MySlider> _slider = [];
  List<MySlider> get slider => _slider;
  List<Category> _category = [];
  List<Category> get category => _category;
  int catid = 0;
 
  Color1 colorProduct = Color1(color: 'Select...');
  double rating = 0.0;
  int indexnavigationbar = 0;
  int indexHomeScreen = 0;
  List<Product> _productbycatid = [];
  List<Product> get productbycatid {
    return [..._productbycatid];
  }

  List<Product> productjustthree = [];

  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

 

  Future<void> getproductbycatid(int catid) async {
       SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
    tokentype=  prefs.getString('token')!;
    }
    else
    tokentype='';
    try {
      Dio.Response response = await dio().get('/categories/$catid',
          options: Dio.Options(headers: {
            "Connection": "Keep-Alive",
            'Authorization': 'Bearer $tokentype'
          }));
      if (response.statusCode == 200) {
        _productbycatid =
            (response.data as List).map((x) => Product.fromJson(x)).toList();
        //print(_items[0].images[0].toString());

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getslider() async {
    try {
      Dio.Response response = await dio().get('/sliders/',
          options: Dio.Options(headers: {
            "Connection": "Keep-Alive",
          }));
      if (response.statusCode == 200)
        _slider =
            (response.data as List).map((x) => MySlider.fromJson(x)).toList();
      //print(_slider.toString());

      notifyListeners();
    } on Dio.DioError catch (e) {
      print(e);
    }
  }

  Future<void> getthreeproduct(int catid, int proid) async {
       SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
    tokentype=  prefs.getString('token')!;
    }
    else
    tokentype='';
    try {
      Dio.Response response = await dio().get('/categories/like/$catid/$proid',
          options: Dio.Options(headers: {
            "Connection": "Keep-Alive",
            'Authorization': 'Bearer $tokentype'
          }));
      if (response.statusCode == 200)
        productjustthree =
            (response.data as List).map((x) => Product.fromJson(x)).toList();
      print(productjustthree.toList());

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void selectnamecom(String comselect) {
    _namecomselect = comselect;
    notifyListeners();
  }

  void rating1(double rating1) {
    rating = rating1;
    notifyListeners();
  }

  Category getcatidtoname(int catId) {
    return _category.firstWhere((element) {
      if (element.categoryid == catId) {
        catid = catId;
        return true;
      }

      return false;
    });
  }

  Product findByCat(int catId) {
    return _items.firstWhere((element) => element.categoryId == catId);
  }

  Product findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Product findByname(String name) {
    return _items.firstWhere((element) => element.name == name);
  }

  void indexcolorp(Color1 colorproduct) {
    colorProduct = colorproduct;
    notifyListeners();
  }

  void indexNavigationBar(int inde) {
    indexnavigationbar = inde;
    notifyListeners();
  }

  void getindexHomeScreen(int inde) {
    indexHomeScreen = inde;
    notifyListeners();
  }

  Future<void> fetchAndSetProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
    tokentype=  prefs.getString('token')!;
    }
    else
    tokentype='';
    try {
      Dio.Response response = await dio().get('/products/',
          options: Dio.Options(headers: {
            "Connection": "Keep-Alive",
            'Authorization': 'Bearer $tokentype'
          }));
      if (response.statusCode == 200)
        _items =
            (response.data as List).map((x) => Product.fromJson(x)).toList();

      notifyListeners();
    } on Dio.DioError catch (e) {
      if (e.response != null) throw e.response.toString();
    }
  }

  Future<void> fetchAndSetProductsbestsller() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
    tokentype=  prefs.getString('token')!;
    }
    else
    tokentype='';
    try {
      Dio.Response response = await dio().get('/product/best_products',
          options: Dio.Options(headers: {
            "Connection": "Keep-Alive",
            'Authorization': 'Bearer $tokentype'
          }));
      if (response.statusCode == 200)
        _items =
            (response.data as List).map((x) => Product.fromJson(x)).toList();

      notifyListeners();
    } catch (e) {
      // if (e.response != null) throw e.response.toString();
    }
  }

  Future<void> fetchAndSetCategory() async {
    try {
      Dio.Response response = await dio().get('/categories');
      if (response.statusCode == 200) {
        _category =
            (response.data as List).map((x) => Category.fromJson(x)).toList();

        // print(_category.toString());
        notifyListeners();
      }
    } on Dio.DioError catch (e) {
      print(e);
    }
  }

  Future<void> fetchAndSetCompany() async {
    try {
      Dio.Response response = await dio().get('/product/company');

      _comname =
          (response.data as List).map((x) => Company.fromJson(x)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> productflitter(Map cards, int? cat) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
    tokentype=  prefs.getString('token')!;
    }
    else
    tokentype='';
    try {
      if (cat != null) {
        Dio.Response response = await dio().post('/product/fillter_category',
            data: cards,
            options: Dio.Options(headers: {
              "Connection": "Keep-Alive",
              'Authorization': 'Bearer $tokentype'
            }));
        _productbycatid =
            (response.data as List).map((x) => Product.fromJson(x)).toList();
      } else {
        Dio.Response response = await dio().post('/product/fillter',
            data: cards,
            options: Dio.Options(headers: {
              "Connection": "Keep-Alive",
              'Authorization': 'Bearer $tokentype'
            }));
        _items =
            (response.data as List).map((x) => Product.fromJson(x)).toList();
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    _namecomselect = null;
  }

  Future<void> getrangepricebycat(Map cards) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
    tokentype=  prefs.getString('token')!;
    }
    else
    tokentype='';
    try {
      Dio.Response response = await dio().post('/product/product_rang',
          data: cards,
          options: Dio.Options(headers: {
            "Connection": "Keep-Alive",
             'Authorization': 'Bearer $tokentype'
          }));
      _rangeprice = response.data.cast<int>();

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getrangepriceallproduct() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
    tokentype=  prefs.getString('token')!;
    }
    else
    tokentype='';
    
    try {
      Dio.Response response = await dio().post('/product/product_rang',
          options: Dio.Options(headers: {
            "Connection": "Keep-Alive",
             'Authorization': 'Bearer $tokentype'
          }));
      _rangeprice = response.data.cast<int>();

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
