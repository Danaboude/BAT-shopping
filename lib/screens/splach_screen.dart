import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project1/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

import '../providers/fatchdata.dart';
import '../providers/auth.dart';
import '../providers/cart.dart';

class SplachScreen extends StatefulWidget {
      static const routeName = '/splach';

  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
      try {
      Provider.of<Auth>(context, listen: false).readuserwithtoken();
      Provider.of<Fatchdata>(context, listen: false).getslider();
      Provider.of<Fatchdata>(context, listen: false).fetchAndSetProducts();
      Provider.of<Fatchdata>(context, listen: false).fetchAndSetCategory();
      Provider.of<Cart>(context, listen: false).fatchandsetcart();
      Provider.of<Fatchdata>(context, listen: false).fetchAndSetCompany();
      Provider.of<Fatchdata>(context,listen: false).getrangepriceallproduct();
    } catch (e) {
      print(e.toString());
    }

    Future.delayed(const Duration(seconds: 3),  () => Navigator.of(context).pushReplacementNamed(ProductOverviewScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    var sizedphone = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
             decoration: BoxDecoration(
                 // borderRadius: BorderRadius.circular(1),
                 color: Theme.of(context).primaryColor.withOpacity(0.3),
                  
                ),
              height: sizedphone.height * 0.3,
              width: sizedphone.width,
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              decoration: BoxDecoration(
                 // borderRadius: BorderRadius.circular(40),
                  color:  Theme.of(context).primaryColor,
                  
                ),
              height: sizedphone.height * 0.2,
              width: sizedphone.width,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(
                height: sizedphone.height * 0.2,
              ),
                   
                  Center(
                    child:Image.asset('images/logo.png',height:  sizedphone.height*0.5, width: sizedphone.width*0.8,)),
              SizedBox(
                height: sizedphone.height * 0.1,
              ),
              SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color:
                          index.isEven ? const Color(0xFF000000) :Theme.of(context).primaryColor,
                    ),
                  );
                },
              ),
              SizedBox(
                height: sizedphone.height * 0.1,
              ),
            
            ],
          ),
        ],
      )),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height),
        radius: const Radius.elliptical(30, 10));
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
