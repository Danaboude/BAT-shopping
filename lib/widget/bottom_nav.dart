import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/widget/badge.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {

    final items = <Widget>[
      Icon(
        Icons.home,
        size: 30,
      ),
      Badge(
        color: Colors.red,
       
        child: Icon(
          Icons.shopping_cart,
          size: 30,
        ),
      ),
      Icon(
        Icons.account_box,
        size: 30,
      ),
    ];
    int inde = Provider.of<Fatchdata>(context).indexnavigationbar;
    return CurvedNavigationBar(

        //animationDuration: Duration(seconds: 1),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor,
        index: inde,
        height: 60,
        items: items,
        onTap: (index) {
          
            // Navigator.of(context).pop();
              inde = index;
          
              Provider.of<Fatchdata>(context, listen: false).indexNavigationBar(inde);
             
            });
  }
}
