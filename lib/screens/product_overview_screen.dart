// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/providers/auth.dart';
import 'package:project1/screens/account_screen.dart';
import 'package:project1/screens/auth_screen.dart';
import 'package:project1/screens/categories_screen.dart';
import 'package:project1/screens/fliter_screen.dart';
import 'package:project1/screens/product_detail_screen.dart';
import 'package:project1/widget/app_drawer.dart';
import 'package:project1/widget/bottom_nav.dart';
import 'package:project1/widget/products_grid.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/Product_over_view';
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  void initState() {
    super.initState();

  
    //Future.delayed(Duration.zero, () {});
  }

  @override
  Widget build(BuildContext context) {
    final silder = Provider.of<Fatchdata>(context).slider;
    var size1 = MediaQuery.of(context).size;
    print(Provider.of<Auth>(context).token);
    return Scaffold(
      extendBody: true,
      drawer: AppDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              icon: Icon(
                Icons.menu_open,
                color: Colors.black,
              ),
              onPressed: () => Scaffold.of(context).openDrawer());
        }),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Provider.of<Fatchdata>(context).indexnavigationbar == 0
              ? IconButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamed(FliterScreen.routeName);
                  },
                  icon: Icon(
                    Icons.filter_alt,
                    color: Colors.black,
                  ))
              : SizedBox(),
          Provider.of<Fatchdata>(context).indexnavigationbar == 0
              ? IconButton(
                  onPressed: () => showSearch(
                      context: context, delegate: CustomSearchDelegate()),
                  icon: Icon(Icons.search, color: Colors.black))
              : SizedBox(),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: Provider.of<Fatchdata>(context).indexnavigationbar == 0
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size1.height * 0.01,
                      ),
                      SizedBox(
                        height: size1.height * 0.21,
                        width: size1.width * 0.95,
                        child: Provider.of<Fatchdata>(context).slider == []
                            ? Center(
                                child: Text('we don\'t have Slider '),
                              )
                            : CarouselSlider(
                                options: CarouselOptions(
                                  scrollDirection: Axis.horizontal,
                                  enableInfiniteScroll:
                                      silder.length == 1 ? false : true,
                                  autoPlay: silder.length == 1 ? false : true,
                                  viewportFraction: 1,
                                  disableCenter: false,
                                ),
                                items: silder
                                    .map(
                                      (item) => SizedBox(
                                        child: GridTile(
                                          footer: GridTileBar(
                                             // trailing: Text(item.titlear),
                                              subtitle: Text(
                                                item.titleensm,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4)),
                                              ),
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.2),
                                              title: Text(
                                                item.titleenbig,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          child: Hero(
                                              tag: item.id,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: item.image
                                                      .replaceAll('localhost',
                                                          '10.0.2.2'),
                                                  // placeholder: (context, url) =>
                                                  //   Icon(Icons.error),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              )),
                                        ),
                                      ),
                                    )
                                    .toList()),
                      ),
                      SizedBox(
                        height: size1.height * 0.02,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Discover',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: size1.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                              onPressed: () {
                                Provider.of<Fatchdata>(context, listen: false).getindexHomeScreen(0);
                                Provider.of<Fatchdata>(context, listen: false)
                                    .fetchAndSetProducts();
                              },
                              child: Text('All')),
                          FlatButton(
                              onPressed: () {
                                Provider.of<Fatchdata>(context, listen: false).getindexHomeScreen(1);
                              },
                              child: Text('Categories')),
                          FlatButton(
                              onPressed: () {
                                Provider.of<Fatchdata>(context, listen: false).getindexHomeScreen(2);
                                Provider.of<Fatchdata>(context, listen: false)
                                    .fetchAndSetProductsbestsller();
                              },
                              child: Text('Best Product')),
                        ],
                      ),
                      Container(
                          height: size1.height * 0.48,
                          width: size1.width * 0.9,
                          child: Provider.of<Fatchdata>(context, listen: false)
                                      .indexHomeScreen ==
                                  0
                              ? RefreshIndicator(
                                  onRefresh: () =>
                                      Provider.of<Fatchdata>(context, listen: false)
                                          .fetchAndSetProducts(),
                                  child: ProductGrid())
                              : Provider.of<Fatchdata>(context).indexHomeScreen == 1
                                  ? CategoriesScreen()
                                  : RefreshIndicator(
                                      onRefresh: () =>
                                          Provider.of<Fatchdata>(context, listen: false)
                                              .fetchAndSetProducts(),
                                      child: ProductGrid())),
                    ],
                  ),
                )
              : Provider.of<Fatchdata>(context).indexnavigationbar == 1
                  ? CartScreen()
                  : Provider.of<Auth>(context).authevtivated
                      ? AccountScreen()
                      : Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Plasce Login to sea imformtion',
                            ),
                            FlatButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(AuthScreen.routeName),
                                child: Text('Login'))
                          ],
                        )),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> seachTerms = [
    'Red Shirt',
    'Tshort',
    'Soop',
    'Oranges',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.clear,
          ))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in seachTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        var item = Provider.of<Fatchdata>(context).findByname(result);

        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: {'name': item});
          },
          title: Text(result),
        );
      },
      itemCount: matchQuery.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in seachTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
      itemCount: matchQuery.length,
    );
  }
}
