import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project1/providers/cart.dart';
import 'package:provider/provider.dart';

class CartIteme extends StatefulWidget {
  final int id;
  final int productId;
  final int quantity;
  final int price;
  final String title;
  final String imgUrl;
  final String catname;
  final String? color;

  const CartIteme({
    required this.color,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
    required this.imgUrl,
    required this.catname,
  });

  @override
  State<CartIteme> createState() => _CartItemeState();
}
@override

class _CartItemeState extends State<CartIteme> {
    TextEditingController _controller = TextEditingController();
  void initState() {
  super.initState();
  _controller.text = widget.quantity.toString();
}
  @override
  Widget build(BuildContext context) {
    var sizephone = MediaQuery.of(context).size;
  
    

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: sizephone.height * 0.04,
          ),
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
                    imageUrl: widget.imgUrl,
                    // placeholder: (context, url) =>
                    //   Icon(Icons.error),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  width: sizephone.width * 0.01,
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.catname,
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Container(
                          width: 60.0,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  onChanged: (value)  =>
                                       Provider.of<Cart>(context,
                                              listen: false)
                                          .totalafterEditQuntity(
                                              widget.id, int.parse(value)),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                  ),
                                  controller: _controller,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Container(
                                //height: 38.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: InkWell(
                                        child: Icon(
                                          Icons.arrow_drop_up,
                                          size: 18.0,
                                        ),
                                        onTap: () {
                                          int currentValue =
                                              int.parse(_controller.text);
                                          currentValue++;
                                          _controller.text =
                                              currentValue.toString();
                                          Provider.of<Cart>(context, listen: false).totalafterEditQuntity(widget.id,currentValue);
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 18.0,
                                      ),
                                      onTap: () {
                                        int currentValue =
                                            int.parse(_controller.text);
                                        if (currentValue != 1) currentValue--;
                                        _controller.text =
                                            currentValue.toString();
                                        Provider.of<Cart>(context, listen: false).totalafterEditQuntity(widget.id,currentValue);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: sizephone.width * 0.2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '\$${widget.price}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: sizephone.height * 0.01,
                    ),
                    // CircleAvatar(
                    //  radius: sizephone.height * 0.015,
                    //  backgroundColor: Colors.red,
                    // ),
                    Text(widget.color.toString() == 'Select..'
                        ? 'Unknwon'
                        : widget.color.toString()),
                    SizedBox(
                      height: sizephone.height * 0.01,
                    ),
                    IconButton(
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .removeItem(widget.productId);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
