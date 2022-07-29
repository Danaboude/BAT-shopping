import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/providers/company.dart';
import 'package:project1/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

class FliterScreen extends StatefulWidget {
  static const routeName = '/fliter';

  @override
  _FliterScreenState createState() => _FliterScreenState();
}

class _FliterScreenState extends State<FliterScreen> {
  double _startValue = 0;

  double _endValue = 0;

  @override
  Widget build(BuildContext context) {
    int? args = ModalRoute.of(context)!.settings.arguments as int?;

    List<int>? range = Provider.of<Fatchdata>(context).rangeprice.isEmpty
        ? [0, 200000]
        : Provider.of<Fatchdata>(context).rangeprice;
    var sizephone = MediaQuery.of(context).size;
    final namecomany = Provider.of<Fatchdata>(context).comname;
    final minrange =0.0;
    final maxrange = range[1].toDouble() ;
 //   print(_endValue + range[1].toDouble());
   // _startValue = _startValue +minrange ;
   // _endValue = _endValue +minrange;

    String? name = Provider.of<Fatchdata>(context).namecomselect;
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: sizephone.width * 0.03,
          ),
          IconButton(
              onPressed: () {
                Provider.of<Fatchdata>(context, listen: false).fetchAndSetProducts();

                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              )),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductOverviewScreen.routeName);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              'Choose Company',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          SizedBox(
            height: sizephone.height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Container(
              height: sizephone.height * 0.09,
              width: sizephone.width * 0.2,
              alignment: Alignment.center,
              child: Container(
                  child: PopupMenuButton<Company>(
                      onSelected: (value) {
                        Provider.of<Fatchdata>(context, listen: false)
                            .selectnamecom(value.comname);
                      },
                      child: Container(
                        height: sizephone.height * 0.06,
                        width: sizephone.width * 0.2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            )),
                        child: Center(
                          child: Text(
                            Provider.of<Fatchdata>(context).namecomselect == null
                                ? 'Select..'
                                : Provider.of<Fatchdata>(context).namecomselect!,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      itemBuilder: (context) {
                        return namecomany
                            .map((item) => PopupMenuItem<Company>(
                                  value: item,
                                  child: Text(
                                    item.comname,
                                  ),
                                ))
                            .toList();
                      })),
            ),
          ),
          SizedBox(
            height: sizephone.height * 0.02,
          ),
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              'Choose Price',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          SizedBox(
            height: sizephone.height * 0.04,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 39, vertical: 10),
                alignment: Alignment.centerLeft,
                child: RangeSlider(
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.black,
                  min: minrange,
                  max: maxrange,
                  divisions: 10,
                  labels: RangeLabels(
                    _startValue.round().toString(),
                    _endValue.round().toString(),
                  ),
                  values: RangeValues(_startValue, _endValue),
                  onChanged: (values) {
                    setState(() {
                      _startValue = values.start;
                      _endValue = values.end;
                    });
                  },
                )),
          ),
          ElevatedButton(
            child: Text('Flitter'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              minimumSize:
                  Size(sizephone.width * 0.32, sizephone.height * 0.063),
            ),
            onPressed: () async {
              Map cart = args==null?{
                'company': name,
                'min_price': _startValue,
                'max_price': _endValue,
              }:{
                'category_id':args,
                'company': name,
                'min_price': _startValue,
                'max_price': _endValue,
              };
              await Provider.of<Fatchdata>(context, listen: false)
                  .productflitter(cart, args);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
