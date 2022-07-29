import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/providers/cart.dart';
import 'package:project1/providers/category.dart';
import 'package:project1/providers/color1.dart';
import 'package:project1/providers/imagee.dart';
import 'package:project1/screens/auth_screen.dart';
import 'package:project1/widget/app_drawer.dart';
import 'package:project1/widget/namber_input.dart';
import 'package:project1/widget/star_rating.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    List<Imagee> list = [];

    List<Color1> lcolor = [];

    final args = ModalRoute.of(context)!.settings.arguments as int;
    final loadedcategory = Provider.of<Fatchdata>(context).category;
    final loadedProduct = Provider.of<Fatchdata>(context, listen: true).findById(args);
    double rating = Provider.of<Fatchdata>(context, listen: true).rating;
    var colorproduct = Provider.of<Fatchdata>(context, listen: true).colorProduct;
    list.addAll(loadedProduct.images);
    lcolor.addAll(loadedProduct.colors);
    Category category = loadedcategory.firstWhere(
        (element) => element.categoryid == loadedProduct.categoryId);
    var materialStatus;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        //  bottomNavigationBar: BottomNav(),
        drawer: AppDrawer(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100))),
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  centerTitle: true,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 4,
                        child: Text(category.title, textAlign: TextAlign.center),
                      ),
                      Flexible(
                        flex: 7,
                        child: Container(
                          height: deviceSize.height*0.3,width: deviceSize.width*0.6,
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              child: Icon(Icons.favorite),
                              style: ElevatedButton.styleFrom(
                                elevation: 1,
                                primary: Theme.of(context).primaryColor,
                                shadowColor: Colors.amber,
                                onSurface: Colors.black,
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(10),
                              ),
                              onPressed: () => null),
                        ),
                      ),
                    ],
                  ),
                  //Text()
                  background: CarouselSlider(
                      options: CarouselOptions(
                        enableInfiniteScroll:
                            loadedProduct.images.length == 1 ? false : true,
                        autoPlay: loadedProduct.images.length == 1 ? false : true,
                        viewportFraction: 1,
                        disableCenter: false,
                      ),
                      items: list
                          .map(
                            (item) => Hero(

                                tag: loadedProduct.id,
                                child: ClipRRect(

                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80.0)),
                                  child: CachedNetworkImage(
                                    height: deviceSize.height*0.7,
                                    width: deviceSize.width*0.92,
                                    fit: BoxFit.cover,
                                    imageUrl: item.image
                                        ,
                                    // placeholder: (context, url) =>
                                    //   Icon(Icons.error),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )),
                          )
                          .toList()),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: deviceSize.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        loadedProduct.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        '\$${loadedProduct.priceRetail}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(loadedProduct.size),
                      ),
                      Container(
                        child: StarRating(
                            rating: rating,
                            onRatingChanged: (val) {
                              Provider.of<Fatchdata>(context, listen: false).rating1(val);
                            },
                            color: Theme.of(context).primaryColor),
                      ),
                      PopupMenuButton<Color1>(
                        onSelected: (value) {
                          Provider.of<Fatchdata>(context, listen: false)
                              .indexcolorp(value);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        itemBuilder: (context) {
                          return lcolor
                              .map((item) => PopupMenuItem<Color1>(
                                    value: item,
                                    child: Text(
                                      item.color,
                                    ),
                                  ))
                              .toList();
                        },
                        child: materialStatus == null
                            ? Container(
                                height: deviceSize.height * 0.06,
                                width: deviceSize.width * 0.2,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    )),
                                child: Center(
                                  child: Text(
                                    colorproduct.color,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                            : Text(
                                materialStatus,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.03,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Descripition',
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      loadedProduct.descripition +
                          ' Company ' +
                          loadedProduct.company,
                      //textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: deviceSize.height * 0.06,
                        width: deviceSize.width * 0.4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            primary: Theme.of(context).primaryColor, // background
                            onPrimary: Colors.black, // foreground
                          ),
                          onPressed: () {
                            print(Provider.of<Cart>(context, listen: false).quntity);
                            if (Provider.of<Auth>(context, listen: false).token !=
                                '') {
                              Provider.of<Cart>(context, listen: false).addItem(
                                  loadedProduct.id,
                                  loadedProduct.categoryId,
                                  loadedProduct.images[0].image,
                                  loadedProduct.priceRetail,
                                  loadedProduct.name,
                                  colorproduct.color[0],
                                  Provider.of<Cart>(context, listen: false).quntity);
                              Provider.of<Fatchdata>(context, listen: false)
                                  .indexcolorp(Color1(color: 'Select..'));
                            } else {
                              Navigator.of(context)
                                  .pushNamed(AuthScreen.routeName);
                            }
                          },
                          child: Text(
                            'Add To Cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      NumberInputWithIncrementDecrement(1)
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'You May Also Like',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      height: deviceSize.height * 0.03),
                  AolsLike(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AolsLike extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizephone = MediaQuery.of(context).size;
    final loadedcategory = Provider.of<Fatchdata>(context).category;
    final product = Provider.of<Fatchdata>(context, listen: false).productjustthree;

     print(product);
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: product.length,
        //itemExtent: 50,
        itemBuilder: (context, index) {
          Category category = loadedcategory.firstWhere(
              (element) => element.categoryid == product[index].categoryId);
          return GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product[index].id),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        width: sizephone.width * 0.2,
                        height: sizephone.height * 0.12,
                        padding: EdgeInsets.all(4),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: product[index]
                              .images[0]
                              .image
                              ,
                          // placeholder: (context, url) =>
                          //   Icon(Icons.error),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        width: sizephone.width * 0.01,
                      ),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            product[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            category.title,
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          IconButton(
                              onPressed: () =>
                                  Provider.of<Cart>(context, listen: false)
                                      .addItem(
                                          product[index].id,
                                          product[index].categoryId,
                                          product[index].images[0].image,
                                          product[index].priceRetail,
                                          product[index].name,
                                          Provider.of<Fatchdata>(context, listen: false)
                                              .colorProduct
                                              .color,
                                          Provider.of<Cart>(context, listen: false)
                                              .quntity),
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Color(0xff21b6a8),
                              )),
                        ],
                      ),
                      SizedBox(
                        width: sizephone.width * 0.2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '\$${product[index].priceRetail}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: sizephone.height * 0.1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: sizephone.height * 0.02,
                )
              ],
            ),
          );
        });
  }
}
