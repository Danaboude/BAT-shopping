import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/screens/fliter_screen.dart';
import 'package:project1/screens/product_overview_screen.dart';
import 'package:project1/widget/product_items.dart';
import 'package:project1/widget/skeleton.dart';
import 'package:provider/provider.dart';

class CategoriesScreen1 extends StatefulWidget {
  static const routeName = '/Categories1';

  @override
  State<CategoriesScreen1> createState() => _CategoriesScreen1State();
}

class _CategoriesScreen1State extends State<CategoriesScreen1> {
  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizephone = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as int;

    final items = Provider.of<Fatchdata>(context).productbycatid;

    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              SizedBox(),
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.filter_alt),
                  color: Colors.black,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(FliterScreen.routeName,arguments: args),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              Provider.of<Fatchdata>(context).getcatidtoname(args).title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: sizephone.height * 0.1,
          ),
          Container(
              height: sizephone.height * 0.7,
              width: sizephone.width * 0.5,
              child: Container(
                padding: EdgeInsets.all(8),
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 8 / 6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int i) =>
                      ChangeNotifierProvider.value(
                    value: items[i],
                    child: _isLoading
                        ? Stack(
                            children: [
                              Skeleton(
                                height: sizephone.height * 0.2,
                                width: sizephone.width * 0.4,
                              ),
                              Column(children: [
                                SizedBox(
                                  height: sizephone.height * 0.140,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Skeleton(
                                      width: sizephone.width * 0.07,
                                    ),
                                    Skeleton(
                                      width: sizephone.width * 0.14,
                                    ),
                                    Skeleton(width: sizephone.width * 0.07),
                                    SizedBox(
                                      height: sizephone.height * 0.01,
                                    ),
                                  ],
                                ),
                              ])
                            ],
                          )
                        : ProductItem(),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
