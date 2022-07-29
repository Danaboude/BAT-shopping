

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/providers/auth.dart';
import 'package:project1/providers/cart.dart';
import 'package:project1/providers/orders.dart';
import 'package:project1/screens/Categories_screen1.dart';
import 'package:project1/screens/about_us.dart';
import 'package:project1/screens/account_screen.dart';

import 'package:project1/screens/categories_screen.dart';
import 'package:project1/screens/edit_profile_screen.dart';
import 'package:project1/screens/fivorte_screen.dart';

import 'package:project1/screens/fliter_screen.dart';
import 'package:project1/screens/splach_screen.dart';
import 'package:project1/screens/product_detail_screen.dart';
import 'package:project1/screens/product_overview_screen.dart';
import 'package:project1/screens/settings.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';

void main() async{

  
  WidgetsFlutterBinding.ensureInitialized();
    changeStatusColor(Color(0xff21b6a8));
 // HttpOverrides.global = new MyApp() as HttpOverrides?;
  runApp(MyApp());
}
changeStatusColor(Color color) async {
   var _useWhiteStatusBarForeground ;
      var _useWhiteNavigationBarForeground;
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      if (useWhiteForeground(color)) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
         _useWhiteStatusBarForeground = true;
         _useWhiteNavigationBarForeground = true;
      } else { 
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
        _useWhiteStatusBarForeground = false;
        _useWhiteNavigationBarForeground = false;
      }
    }  catch (e) {
      debugPrint(e.toString());
    }
  }

class MyApp extends StatelessWidget {
  
  
  
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
      //  ChangeNotifierProvider.value(value: Auth()),
       // ChangeNotifierProvider.value(value: Products()),
        //ChangeNotifierProvider.value(value: Cart()),
        
       // ChangeNotifierProvider.value(value: A()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders()),
          ChangeNotifierProvider(
       create: (_) => Auth()
    ),
    ChangeNotifierProvider(
       create: (_) => Fatchdata()
    ),


        //ChangeNotifierProvider.value(value: Product()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          
          drawerTheme: DrawerThemeData(scrimColor: Colors.white.withOpacity(0.3)),
          iconTheme: IconThemeData(color: Colors.black),
          primaryColor: Color(0xff21b6a8),
        //  accentColor: Colors.black,
        ),
        routes: {
          EditProductScreen.routeName:(_)=>EditProductScreen(),
             ProductOverviewScreen.routeName: (_) => ProductOverviewScreen(),
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
          CategoriesScreen.routeName: (_) => CategoriesScreen(),
          FliterScreen.routeName: (_) => FliterScreen(),          AuthScreen.routeName: (_) => AuthScreen(),
          AboutUs.routeName: (_) => AboutUs(),
          SplachScreen.routeName: (_) => SplachScreen(),
          AccountScreen.routeName:(_)=>AccountScreen(),
          CategoriesScreen1.routeName:(_)=>CategoriesScreen1(),
         Settings.routeName:(_)=>Settings(),
         FavoriteScreen.routeName:(_)=>FavoriteScreen(),
        // Pay.routeName:(_)=>Pay(),
        },
        debugShowCheckedModeBanner: false,
        home: SplachScreen(),
      ),
    );
  }
}
