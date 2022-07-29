import 'package:flutter/material.dart';
import 'package:project1/providers/cart.dart';
import 'package:provider/provider.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final Color color;

  const Badge({
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    int val = Provider.of<Cart>(context).itemCount;

    return Stack(
      alignment: Alignment.topRight,
      children: [
        child,
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
            ),
            constraints: BoxConstraints(
              minHeight: 16,
              minWidth: 16,
            ),
            padding: EdgeInsets.all(2),
            child: Text(
              val.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
