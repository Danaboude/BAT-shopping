import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/providers/auth.dart';

import 'package:project1/providers/cart.dart';
import 'package:project1/providers/product.dart';
import 'package:project1/screens/auth_screen.dart';
import 'package:project1/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    // final cart = Provider.of<Cart>(context, listen: false);
    // final authdata = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () async {
              await Provider.of<Fatchdata>(context, listen: false)
                  .getthreeproduct(product.categoryId, product.id);

              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Hero(
              tag: product.id,
              child: product.images.isEmpty
                  ? Placeholder()
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: product.images[0].image
                          ,
                      // placeholder: (context, url) =>
                      //   Icon(Icons.error),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.grey.withOpacity(0.2),
            title: Text(
              product.name,
              style: TextStyle(color: Colors.black),
            ),
            trailing: Text(
              product.priceRetail.toString(),
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
                onPressed: () {
                  if (Provider.of<Auth>(context, listen: false).token != '')
                    Provider.of<Cart>(context, listen: false).addItem(
                      product.id,
                      product.categoryId,
                      product.images[0].image,
                      product.priceRetail,
                      product.name,
                      product.colors.isEmpty
                          ? 'UnKnowen'
                          : product.colors[0].color,
                      Provider.of<Cart>(context, listen: false).quntity,
                    );
                  else
                    Navigator.of(context).pushNamed(AuthScreen.routeName);
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                )),
          ),
        ));
  }
}
