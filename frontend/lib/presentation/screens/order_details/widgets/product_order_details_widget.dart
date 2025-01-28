import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../data/models/product_item_model.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/custom_shadow_container.dart';
import '../../../widgets/icon_title_widget.dart';
import '../../../widgets/row_item.dart';

class ProductOrderDetailsWidget extends StatelessWidget {
  final ProductItemModel orderItem;

  const ProductOrderDetailsWidget({
    super.key,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShadowContainer(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 20.h,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImage(
                imageUrl: orderItem.productId.image,
                height: 59,
                width: 59,
                memCacheHeight: 59.w.cacheSize(context),
                memCacheWidth: 59.w.cacheSize(context),
                radius: 9,
              ),
              SizedBox(
                width: 11.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderItem.productId.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconTitleWidget(
                          icon: SvgImages.money,
                          title: HelperFunctions.getPrice(
                            orderItem.productPrice,
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Text(
                          AppStrings.quantity.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          orderItem.amount.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (orderItem.options.isNotEmpty) ...[
            Divider(
              height: 20.h,
            ),
            ...orderItem.options.map((option) => Column(
                  children: [
                    RowItem(
                      title: option.key,
                      content: option.value,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                  ],
                )),
          ],
        ],
      ),
    );
  }
}
