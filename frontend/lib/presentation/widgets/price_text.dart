import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/helper_functions.dart';

class PriceText extends StatelessWidget {
  final num price;
  final num offerPrice;

  const PriceText({
    super.key,
    required this.price,
    required this.offerPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text:
            '${HelperFunctions.getPrice(offerPrice > 0 ? offerPrice : price)} ',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        children: offerPrice > 0
            ? [
                TextSpan(
                  text: '(${HelperFunctions.toStringAsFixed(price)})',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
