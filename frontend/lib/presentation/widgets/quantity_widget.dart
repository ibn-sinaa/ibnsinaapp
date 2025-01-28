import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/themes/app_colors.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_strings.dart';

class QuantityWidget extends StatelessWidget {
  final num amount;
  final bool showIcon;
  final bool showQuantity;

  const QuantityWidget({
    super.key,
    required this.amount,
    this.showIcon = true,
    this.showQuantity = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 13.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.cF1F5FB,
        borderRadius: BorderRadius.circular(
          8.r,
        ),
      ),
      child: Column(
        children: [
          if (showQuantity)
            Text(
              AppStrings.quantity.tr(),
              style: TextStyle(fontSize: 10.sp),
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                amount.toString(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              if (showIcon) ...[
                SizedBox(
                  width: 22.w,
                ),
                SvgPicture.asset(
                  SvgImages.downArrow,
                  height: 8.h,
                )
              ]
            ],
          ),
        ],
      ),
    );
  }
}
