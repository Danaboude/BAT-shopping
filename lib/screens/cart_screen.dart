
import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/providers/auth.dart';
import 'package:project1/providers/orders.dart';
import 'package:project1/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/cart_item.dart';
import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    var sizephone = MediaQuery.of(context).size;
    final cart = Provider.of<Cart>(context);
    final cartp = Provider.of<Cart>(context).items;
    final token = Provider.of<Auth>(context).token;

    return Column(
      children: [
        SizedBox(
          height: sizephone.height*0.02,
        ),
        Expanded(
          flex: 1,
          child:const Text(
            'Shoping Cart',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 6,
          child: ListView.builder(
            itemBuilder: (ctx, int index) {
              print(cart.items.values.toList()[index].id);
              return  CartIteme(
                color: cart.items.values.toList()[index].color,
                productId: cart.items.values.toList()[index].id,
                id: cart.items.values.toList()[index].id,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quntity,
                title: cart.items.values.toList()[index].title,
                imgUrl: cart.items.values.toList()[index].imgUrl,
                catname: Provider.of<Fatchdata>(context)
                    .getcatidtoname(
                        cart.items.values.toList()[index].catgoryname)
                    .title,
              );
            },
            itemCount: cart.items.length,
          ),
        ),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               const Text(
                  'Total',
                  style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(),
                Text(
                  '\$${cart.totalAmount.toStringAsFixed(2)}',
                  style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        Expanded(
          flex: 1,
          child: Container(
            width: sizephone.width * 0.7,
            child: ElevatedButton(autofocus: true,
            
              child:const Text('Chackout'),
              onPressed:Provider.of<Cart>(context).totalAmount!=0? () async {
                if (token != '') {
                  Provider.of<Orders>(context, listen: false)
                      .addOrder(cartp, token, cart.totalAmount);
                  Provider.of<Cart>(context, listen: false).clear();
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.remove('itemscart');
                  
                } else
                  Navigator.of(context).pushNamed(AuthScreen.routeName);
              }:null,
              style: ElevatedButton.styleFrom(
                //minimumSize: Size(sizephone.width*0.3, sizephone.height*0.01),
                primary:Theme.of(context).primaryColor,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: sizephone.height * 0.13,
        )
      ],
    );
  }
}
