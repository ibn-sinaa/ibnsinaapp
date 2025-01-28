import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import '../../data/models/option_data/option_data_model.dart';
import 'cached_image.dart';

import '../../config/themes/app_colors.dart';
import '../../cubit/order_flow/order_flow_cubit.dart';
import '../../data/models/cart/cart_model.dart';
import '../../data/models/option_model/option_model.dart';

class OptionWidget extends StatelessWidget {
  final OptionModel option;
  final void Function(OptionDataModel optionData) onTap;
  final EdgeInsetsGeometry padding;
  final OptionDataModel? value;
  final bool showDivider;

  const OptionWidget({
    super.key,
    required this.option,
    required this.onTap,
    this.padding = EdgeInsets.zero,
    this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Text(
            '● ${option.name}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        SizedBox(
          height: 14.h,
        ),
        GridView.builder(
          padding: padding,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final currentOptionData = option.data[index];
            return GestureDetector(
              onTap: () {
                HelperFunctions.unFocusKeyboard();
                onTap(currentOptionData);
              },
              child: _Item(
                optionData: currentOptionData,
                value: value,
              ),
            );
          },
          itemCount: option.data.length,
        ),
        if (showDivider) ...[
          const Divider(
            height: 0,
          ),
          SizedBox(
            height: 24.h,
          ),
        ]
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final OptionDataModel optionData;
  final OptionDataModel? value;

  const _Item({
    required this.optionData,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: BlocBuilder<OrderFlowCubit, CartModel>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  color: AppColors.cF1F5FB.withOpacity(0.54),
                  borderRadius: BorderRadius.circular(14.r),
                  border: value == optionData
                      ? Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2.w,
                        )
                      : optionData.isSelected
                          ? Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2.w,
                            )
                          : null,
                ),
                child: CachedImage(
                  imageUrl: optionData.image,
                  width: double.maxFinite,
                  height: double.maxFinite,
                  memCacheWidth: ((ScreenUtil().screenWidth - 60.w) / 4)
                      .cacheSize(context),
                  radius: 14,
                  enableTap: false,
                  fit: BoxFit.contain,
                  enableShadow: false,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Expanded(
          flex: 2,
          child: Text(
            optionData.name,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.c2D2F3A,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
