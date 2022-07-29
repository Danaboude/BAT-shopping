import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/screens/Categories_screen1.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
     var items=Provider.of<Fatchdata>(context).category;
    var sizephone = MediaQuery.of(context).size;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 12 / 11,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int i) =>
        GridTile(
          child: GestureDetector(
            onTap: () async{
             
              await Provider.of<Fatchdata>(context,listen: false).getproductbycatid(items[i].categoryid);
              await Provider.of<Fatchdata>(context,listen: false).getrangepricebycat({"category_id":items[i].categoryid});
              Navigator.of(context).pushNamed(CategoriesScreen1.routeName,arguments: items[i].categoryid);
            },
            child:items==[]? Center(child:Text('There is No Data')):Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                children: [
                  Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child:  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: items[i].logo,
                    // placeholder: (context, url) =>
                    //   Icon(Icons.error),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  ),
                  Container(
                    child: Center(child: Text( items[i].title)),
                    height: sizephone.height * 0.04,
                    width: sizephone.width * 0.3,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(15)),
                    ),
                    alignment: Alignment.topLeft,
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin:const EdgeInsets.all(10),
            ),
          ),
        ),
      
    );
  }
}
