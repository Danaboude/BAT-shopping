import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/widget/product_items.dart';
import 'package:project1/widget/skeleton.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatefulWidget {
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deciceSize = MediaQuery.of(context).size;
    final items = Provider.of<Fatchdata>(context).items;
    return Container(
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
                      height: deciceSize.height * 0.2,
                      width: deciceSize.width * 0.4,
                    ),
                    Column(children: [
                      SizedBox(
                        height: deciceSize.height * 0.12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Skeleton(width: deciceSize.width*0.07,),
                           Skeleton(width: deciceSize.width*0.14,),
                            Skeleton(width: deciceSize.width*0.07),
                         
                            ],
                      ),
                    ])
                  ],
                )
              : ProductItem(),
        ),
      ),
    );
  }
}
