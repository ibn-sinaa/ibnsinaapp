import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';

import '../../../../config/locale/language_manager.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../../cubit/cart/cart_cubit.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/custom_text_field.dart';

class CouponField extends StatelessWidget {
  final RequestState couponState;
  final TextEditingController couponController;

  const CouponField(
      {super.key, required this.couponState, required this.couponController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: couponController,
            hintText: AppStrings.enterCoupon.tr(),
            enableSuffixPadding: false,
            suffixIcon: SizedBox(
              width: 130.w,
              child: ElevatedButton(
                onPressed: () {
                  HelperFunctions.unFocusKeyboard();
                  if (couponState == RequestState.loaded) {
                    _deleteCoupon(context);
                  } else {
                    _checkCoupon(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: LanguageManager.isEnglish(context)
                        ? BorderRadius.horizontal(
                            right: Radius.circular(AppSizes.radius.r),
                          )
                        : BorderRadius.horizontal(
                            left: Radius.circular(AppSizes.radius.r),
                          ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: getValueForScreenType(context,
                            small: 20, medium: 17, large: 22)
                        .h,
                    horizontal: 24.w,
                  ),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize:
                        getValueForScreenType(context, small: 19, medium: 16)
                            .sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
                child: couponState == RequestState.loading
                    ? const InlineLoading(
                        color: Colors.white,
                        size: 21,
                      )
                    : Text(
                        couponState == RequestState.loaded
                            ? AppStrings.delete.tr()
                            : AppStrings.confirm.tr(),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _checkCoupon(BuildContext context) {
    if (couponController.text.isEmpty) {
      HelperFunctions.showToastMessage(
        context,
        AppStrings.pleaseEnterCoupon.tr(),
      );
    } else {
      context.read<CartCubit>().checkCoupon(couponController.text);
    }
  }

  void _deleteCoupon(BuildContext context) {
    context.read<CartCubit>().deleteCoupon();
    couponController.text = '';
    HelperFunctions.showToastMessage(
      context,
      AppStrings.couponDeleted.tr(),
    );
  }
}
