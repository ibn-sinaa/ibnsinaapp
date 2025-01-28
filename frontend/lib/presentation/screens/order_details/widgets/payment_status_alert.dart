import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/presentation/widgets/custom_shadow_container.dart';

class PaymentStatusAlert extends StatelessWidget {
  const PaymentStatusAlert({
    super.key,
    required this.paymentStatus,
    required this.invoiceUrl,
    required this.orderType,
    required this.routeName,
  });

  final String paymentStatus;
  final String invoiceUrl;
  final OrderType orderType;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return CustomShadowContainer(
      padding: paymentStatus == 'new'
          ? null
          : EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              top: 15.h,
              bottom: 11.h,
            ),
      bgColor: paymentStatus == 'new'
          ? AppColors.cEF5350.withOpacity(0.1)
          : AppColors.c0CA000.withOpacity(0.1),
      enableShadow: false,
      child: Row(
        children: [
          Text(
            '${AppStrings.paymentStatus.tr()} : ',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: paymentStatus == 'new'
                  ? AppColors.cEF5350
                  : AppColors.c0CA000,
            ),
          ),
          Text(
            paymentStatus == 'new'
                ? AppStrings.paymentHasNotBeenDone.tr()
                : AppStrings.paymentIsDone.tr(),
            style: TextStyle(
              fontSize: 12.sp,
              color: paymentStatus == 'new'
                  ? AppColors.cEF5350
                  : AppColors.c0CA000,
            ),
          ),
          const Spacer(),
          if (paymentStatus == 'new') ...[
            SizedBox(
              width: 12.w,
            ),
            InkWell(
              onTap: () {
                AppRouter.pushNamed(
                  context,
                  AppRoutes.payment,
                  arguments: {
                    'url': invoiceUrl,
                    'orderType': orderType,
                    'routeName': routeName,
                  },
                ).then((value) => AppRouter.pop(context, true));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: AppColors.cEF5350,
                      width: AppSizes.borderWidth.r,
                    )),
                child: Text(
                  AppStrings.payNow.tr(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.cEF5350,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
