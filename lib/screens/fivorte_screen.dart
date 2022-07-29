

import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/screens/product_overview_screen.dart';
import 'package:project1/widget/product_items.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FavoriteScreen extends StatelessWidget {
    static const routeName = '/favorite';


  @override
  Widget build(BuildContext context) {
      final items = Provider.of<Fatchdata>(context).items;
      var sizephone = MediaQuery.of(context).size;

      return
      Scaffold(
        body: SafeArea(
          child: Column(
            children: [
          
              Container(
               // padding: EdgeInsets.only(top: 40),
                alignment: Alignment.topCenter,
                child: Text('Fivorte',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              ),
               Container(
                //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: Colors.black,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(ProductOverviewScreen.routeName),
                ),
              ),
               SizedBox(height: sizephone.height*0.04,),
              SizedBox(
                height:sizephone.height*0.8 ,
                width: sizephone.width*0.9,
                child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 8 /6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 1,
              ),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int i) =>
                  ChangeNotifierProvider.value(
                value: items[i],
                child: ProductItem(),
              ),
            ),
              ),
            ],
          ),
        )
        ,
      );

    
  }
}