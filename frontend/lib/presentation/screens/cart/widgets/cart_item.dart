import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../cubit/cart/cart_cubit.dart';
import '../../../../data/models/cart/cart_model.dart';
import '../../../widgets/quantity_widget.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/custom_shadow_container.dart';
import '../../../widgets/row_item.dart';

class CartItem extends StatelessWidget {
  final CartModel cartModel;

  const CartItem({
    super.key,
    required this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              context.read<CartCubit>().deleteCartItem(cartModel.id);
            },
            backgroundColor: AppColors.cEF5350,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: AppStrings.delete.tr(),
            borderRadius: BorderRadius.circular(9.r),
          ),
          SizedBox(
            width: 12.w,
          ),
        ],
      ),
      child: CustomShadowContainer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImage(
              imageUrl: cartModel.productImage,
              height: 68,
              width: 68,
              memCacheHeight: 68.w.cacheSize(context),
              memCacheWidth: 68.w.cacheSize(context),
              radius: 9,
            ),
            SizedBox(
              width: 6.64.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartModel.productName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  RowItem(
                    title: AppStrings.price.tr(),
                    customContent: Text(
                      HelperFunctions.getPrice(cartModel.totalPrice),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: cartModel.optionsModels.isEmpty
                              ? cartModel.defaultOptions
                                  .map(
                                    (option) => RowItem(
                                      title: option.key,
                                      content: option.value,
                                    ),
                                  )
                                  .toList()
                              : cartModel.optionsModels
                                  .map(
                                    (option) => RowItem(
                                      title: option.name,
                                      content: option.data
                                          .where((optionData) =>
                                              optionData.isSelected)
                                          .map((optionData) => optionData.name)
                                          .toList()
                                          .join(' - '),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: QuantityWidget(
                          amount: cartModel.amount.key,
                          showIcon: false,
                          showQuantity: true,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
