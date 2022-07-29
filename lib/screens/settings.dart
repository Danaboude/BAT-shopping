import 'package:flutter/material.dart';
import 'package:project1/screens/product_overview_screen.dart';

class Settings extends StatelessWidget {
    static const routeName = '/settings';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft,child: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductOverviewScreen.routeName);
            },
            icon: Icon(Icons.arrow_back_ios)),),
            Align(alignment: Alignment.topCenter,child: Text('Settings',style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),),),
          ],
        )
      ),
      
    );
  }
}