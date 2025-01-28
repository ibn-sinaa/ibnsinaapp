import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../cubit/order_flow/order_flow_cubit.dart';
import '../../../../data/models/cart/cart_model.dart';
import '../../../widgets/custom_shadow_container.dart';
import '../../../widgets/row_item.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../data/models/product_details_model.dart';
import '../../../widgets/price_text.dart';

class ProductDetialWidget extends StatelessWidget {
  final ProductDetailsModel productDetailsModel;

  const ProductDetialWidget({
    super.key,
    required this.productDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    print(productDetailsModel.productModel.defaultOptions.length);
    return CustomShadowContainer(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 12.w,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productDetailsModel.productModel.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${AppStrings.quantitiesStartFrom.tr()} : ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.c989898,
                          ),
                        ),
                        Text(
                          productDetailsModel.productModel.startAmount
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 9.h,
                  bottom: 8.h,
                  left: 9.w,
                  right: 9.w,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: BlocBuilder<OrderFlowCubit, CartModel>(
                  builder: (context, state) {
                    return PriceText(
                      price: state.amount.value,
                      offerPrice: state.amount.offer,
                    );
                  },
                ),
              ),
            ],
          ),
          Divider(
            height: 20.h,
          ),
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final option =
                  productDetailsModel.productModel.defaultOptions[index];
              return RowItem(
                title: option.key,
                content: option.value,
              );
            },
            separatorBuilder: (_, __) {
              return SizedBox(height: 10.h);
            },
            itemCount: productDetailsModel.productModel.defaultOptions.length,
          ),
        ],
      ),
    );
  }
}
