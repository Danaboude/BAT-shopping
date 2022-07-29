import 'package:flutter/material.dart';
import 'package:project1/providers/cart.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NumberInputWithIncrementDecrement extends StatefulWidget {
  int quantity;
  NumberInputWithIncrementDecrement(
    this.quantity,
  );

  @override
  _NumberInputWithIncrementDecrementState createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text =
        widget.quantity.toString(); // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          width: 60.0,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextFormField(
                  onChanged: (value) => Provider.of<Cart>(context,listen: false).setquntity(int.parse(value)),
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
                        onTap: () async {
                          int currentValue = int.parse(_controller.text);
                          currentValue++;

                         Provider.of<Cart>(context, listen: false).setquntity(currentValue);

                          _controller.text = currentValue.toString();
                        },
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: 18.0,
                      ),
                      onTap: () async {
                        int currentValue = int.parse(_controller.text);
                        if (currentValue != 0) currentValue--;
                     Provider.of<Cart>(context, listen: false).setquntity(currentValue);
                        _controller.text = currentValue.toString();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
