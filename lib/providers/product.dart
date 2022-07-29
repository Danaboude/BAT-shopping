
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:project1/providers/color1.dart';
import 'package:project1/providers/imagee.dart';

class Product with ChangeNotifier {
  final int id;
  final int categoryId;
  final String name;
  final String size;
  final List<Color1> colors;
  final String descripition;

  final int priceRetail;
  final List<Imagee> images;
  final String company;

  Product({
    required this.size,
    required this.colors,
    required this.id,
    required this.categoryId,
    required this.name,
    required this.descripition,
    required this.priceRetail,
    required this.images,
    required this.company,
  });

  factory Product.fromJson(dynamic json) {
    List<Imagee>? _images;
     List<Color1>? _colors;
    if (json['images'] != null || json['colors'] != null) {
      var imageObjsJson = json['images'] as List;
   _images =
          imageObjsJson.map((imageJson) => Imagee.fromJson(imageJson)).toList();
      List colorObjsJson = json['colors']??[];
       _colors =
          colorObjsJson.map((colorJson) => Color1.fromJson(colorJson)).toList();
    }
     Map m=json;
      if(m.containsKey('price_retail')){

      return Product(
        id: json['id'] as int,
        name: json['name'] as String,
        size: json['size'] ??'Unknowen',
        categoryId: json['category_id'] as int,
        descripition: json['description']??'No description',
        company: json['company'] ??'No Company',
        priceRetail: json['price_retail'] as int,
        colors: _colors??[],
        images: _images??[],
      );
    } else {
            return Product(
        id: json['id'] as int,
        name: json['name'] as String,
        size: json['size'] ??'Unknowen',
        categoryId: json['category_id'] as int,
        descripition: json['description']??'No description',
        company: json['company'] ??'No Company',
        priceRetail: json['price_wholesale'] as int,
        colors: _colors??[],
        images: _images??[],
      );
    }
    
  }

  @override
  String toString() {
    return 'Product(id: $id, categoryId: $categoryId, name: $name, size: $size, colors: $colors, descripition: $descripition, priceWholesale: $priceRetail, images: $images, company: $company)';
  }
}
