import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'circle_icon.dart';

class CartQuantityCounter extends StatefulWidget {
  final Function(num quantity) onChanged;
  final num initQuantity;

  const CartQuantityCounter({
    super.key,
    required this.onChanged,
    required this.initQuantity,
  });

  @override
  State<CartQuantityCounter> createState() => _CartQuantityCounterState();
}

class _CartQuantityCounterState extends State<CartQuantityCounter> {
  num quantity = 0;

  @override
  void initState() {
    quantity = widget.initQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleIcon(
          onPressed: () {
            setState(() {
              quantity++;
              widget.onChanged(quantity);
            });
          },
          icon: Icons.add,
        ),
        Text(
          quantity.toString(),
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        CircleIcon(
          onPressed: () {
            if (quantity > 0) {
              setState(() {
                quantity--;
                widget.onChanged(quantity);
              });
            }
          },
          icon: Icons.remove,
        ),
      ],
    );
  }
}
