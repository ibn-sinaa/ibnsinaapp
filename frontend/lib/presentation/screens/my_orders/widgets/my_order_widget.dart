import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../widgets/icon_title_widget.dart';

import '../../../widgets/custom_shadow_container.dart';

class MyOrderWidget extends StatelessWidget {
  final int orderId;
  final String orderStatusLabel;
  final num totalPrice;
  final VoidCallback onPressed;
  final Widget? moreContent;

  const MyOrderWidget({
    super.key,
    required this.orderId,
    required this.orderStatusLabel,
    required this.totalPrice,
    required this.onPressed,
    this.moreContent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomShadowContainer(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 20.h,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  SvgImages.myOrders,
                  height: 40,
                  width: 40,
                  colorFilter:
                      AppColors.colorFilter(Theme.of(context).primaryColor),
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
                            '${AppStrings.orderNumber.tr()} (#$orderId)',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          IconTitleWidget(
                            icon: SvgImages.received,
                            title: orderStatusLabel,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      IconTitleWidget(
                        icon: SvgImages.money,
                        title: HelperFunctions.getPrice(totalPrice),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (moreContent != null) moreContent!,
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: onPressed,
                elevation: 0,
                backgroundColor: AppColors.cF5F7F9,
                radius: 4.r,
                foregroundColor: Theme.of(context).primaryColor,
                text: AppStrings.orderDetails.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
