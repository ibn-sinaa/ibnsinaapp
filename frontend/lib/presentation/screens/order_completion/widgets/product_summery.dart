import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/presentation/widgets/row_item1.dart';

class ProductSummery extends StatelessWidget {
  const ProductSummery({
    super.key,
    required this.orderValue,
    this.orderValueAfterDiscount,
    required this.addedValue,
    required this.discountValue,
    required this.shippingCost,
    required this.deliveryType,
  });

  final num orderValue;
  final num? orderValueAfterDiscount;
  final num addedValue;
  final num discountValue;
  final num shippingCost;
  final DeliveryType deliveryType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowItem1(
          title: AppStrings.orderValue.tr(),
          content: HelperFunctions.getPrice(orderValue),
        ),
        SizedBox(
          height: 9.h,
        ),
        RowItem1(
          title: AppStrings.discountValue.tr(),
          content: HelperFunctions.getPrice(discountValue),
        ),
        if (orderValueAfterDiscount != null) ...[
          SizedBox(
            height: 9.h,
          ),
          RowItem1(
            title: AppStrings.orderValueAfterDiscount.tr(),
            content: HelperFunctions.getPrice(orderValueAfterDiscount!),
          ),
        ],
        SizedBox(
          height: 9.h,
        ),
        RowItem1(
          title: AppStrings.addedValue.tr(),
          content: HelperFunctions.getPrice(addedValue),
        ),
        if (deliveryType.isHome()) ...[
          SizedBox(
            height: 9.h,
          ),
          RowItem1(
            title: AppStrings.shippingCost.tr(),
            content: HelperFunctions.getPrice(shippingCost),
          ),
        ]
      ],
    );
  }
}
