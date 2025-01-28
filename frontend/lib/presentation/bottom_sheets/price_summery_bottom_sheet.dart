import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/cubit/hide_bottom_sheet/hide_bottom_sheet_cubit.dart';
import 'package:ibn_sina/presentation/dialogs/sign_in_warnign_dialog.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import '../../config/themes/app_colors.dart';
import '../../core/utils/app_sizes.dart';
import '../../core/utils/app_strings.dart';

class PriceSummeryBottomSheet extends StatefulWidget {
  final Function()? onTap;
  final Widget content;
  final num totalValue;
  final bool hasFixedHeight;

  const PriceSummeryBottomSheet({
    super.key,
    this.onTap,
    required this.content,
    required this.totalValue,
    this.hasFixedHeight = true,
  });

  @override
  State<PriceSummeryBottomSheet> createState() =>
      PriceSummeryBottomSheetState();
}

class PriceSummeryBottomSheetState extends State<PriceSummeryBottomSheet> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HideBottomSheetCubit, bool>(
      listener: (context, state) {
        if (_showDetails == true) {
          setState(() {
            _showDetails = false;
          });
        }
      },
      child: Container(
        height: widget.hasFixedHeight
            ? (_showDetails ? ScreenUtil().screenHeight * 0.5 : null)
            : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.r),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: Offset(0, -2.r),
              blurRadius: 2.r,
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding.w,
            right: AppSizes.horizontalPadding.w,
            top: 12.h,
            bottom: 33.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      HelperFunctions.unFocusKeyboard();
                      _showDetails = !_showDetails;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Icon(
                          _showDetails
                              ? Icons.keyboard_arrow_down_sharp
                              : Icons.keyboard_arrow_up_sharp,
                          size: 30.w,
                          color: AppColors.c707070,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          _showDetails
                              ? AppStrings.hideOrderCostDetails.tr()
                              : AppStrings.showOrderCostDetails.tr(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.c707070,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_showDetails)
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        top: 24.h,
                      ),
                      child: widget.content,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 17.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.06),
                        borderRadius: BorderRadius.circular(
                          _showDetails ? 50.r : AppSizes.radius.r,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.total.tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Text(
                            HelperFunctions.getPrice(widget.totalValue),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: _showDetails ? 40.h : 12.h,
              ),
              SizedBox(
                child: CustomButton(
                  onPressed: () {
                    if (locator<SharedData>().isGuest) {
                      HelperFunctions.unFocusKeyboard();
                      HelperFunctions.showAppDialog<void>(
                        context,
                        barrierDismissible: true,
                        child: const SignInWarningDialog(),
                      );
                    } else {
                      widget.onTap?.call();
                    }
                  },
                  text: AppStrings.orderExecution.tr().toUpperCase(),
                  width: double.maxFinite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
