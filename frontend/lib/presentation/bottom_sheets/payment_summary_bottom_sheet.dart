import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/row_item1.dart';
import '../../core/helpers/helper_functions.dart';
import '../../core/utils/app_images.dart';
import '../../config/themes/app_colors.dart';
import '../../core/utils/app_sizes.dart';
import '../../core/utils/app_strings.dart';

class PaymentSummaryBottomSheet extends StatefulWidget {
  final Function()? onTap;
  final num orderValue;
  final num? orderValueAfterDiscount;
  final num addedValue;
  final num discountValue;
  final num shippingCost;
  final num totalValue;
  final bool readOnly;
  final DeliveryType deliveryType;
  final OrderType orderType;

  const PaymentSummaryBottomSheet({
    super.key,
    this.onTap,
    required this.orderValue,
    this.orderValueAfterDiscount,
    required this.addedValue,
    required this.discountValue,
    required this.shippingCost,
    required this.totalValue,
    this.readOnly = false,
    required this.deliveryType,
    required this.orderType,
  });

  @override
  State<PaymentSummaryBottomSheet> createState() =>
      _PaymentSummaryBottomSheetState();
}

class _PaymentSummaryBottomSheetState extends State<PaymentSummaryBottomSheet> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.horizontalPadding.w,
        right: AppSizes.horizontalPadding.w,
        top: 12.h,
        bottom: 33.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.r),
          bottom: Radius.circular(widget.readOnly ? 40.r : 0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            offset: Offset(0, widget.readOnly ? 0 : -2.r),
            blurRadius: 2.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                if (!widget.readOnly) {
                  setState(() {
                    _showDetails = !_showDetails;
                  });
                }
              },
              child: Container(
                color: Colors.transparent,
                child: widget.readOnly
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizes.verticalPadding.h,
                        ),
                        child: SvgPicture.asset(
                          SvgImages.line,
                          width: 54.w,
                          height: 5.h,
                        ),
                      )
                    : Column(
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
                                ? AppStrings.hideDetails.tr()
                                : AppStrings.showDetails.tr(),
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
          if (_showDetails || widget.readOnly)
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.paymentSummary.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      RowItem1(
                        title: AppStrings.orderValue.tr(),
                        content: HelperFunctions.getPrice(widget.orderValue),
                      ),
                      if (widget.orderType == OrderType.product) ...[
                        SizedBox(
                          height: 9.h,
                        ),
                        RowItem1(
                          title: AppStrings.discountValue.tr(),
                          content:
                              HelperFunctions.getPrice(widget.discountValue),
                        ),
                      ],
                      if (widget.orderValueAfterDiscount != null) ...[
                        SizedBox(
                          height: 9.h,
                        ),
                        RowItem1(
                          title: AppStrings.orderValueAfterDiscount.tr(),
                          content: HelperFunctions.getPrice(
                              widget.orderValueAfterDiscount!),
                        ),
                      ],
                      SizedBox(
                        height: 9.h,
                      ),
                      RowItem1(
                        title: AppStrings.addedValue.tr(),
                        content: HelperFunctions.getPrice(widget.addedValue),
                      ),
                      if (widget.deliveryType.isHome()) ...[
                        SizedBox(
                          height: 9.h,
                        ),
                        RowItem1(
                          title: AppStrings.shippingCost.tr(),
                          content:
                              HelperFunctions.getPrice(widget.shippingCost),
                        ),
                      ]
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 17.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.06),
                    borderRadius: BorderRadius.circular(
                      _showDetails ? 50.r : AppSizes.radius.r,
                    ),
                  ),
                  child: RowItem1(
                    title: AppStrings.total.tr(),
                    content: HelperFunctions.getPrice(widget.totalValue),
                    titleColor: Theme.of(context).colorScheme.secondary,
                    contentColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          if (!widget.readOnly) ...[
            SizedBox(
              height: _showDetails ? 40.h : 12.h,
            ),
            CustomButton(
              onPressed: widget.onTap,
              text: AppStrings.orderExecution.tr().toUpperCase(),
              width: double.maxFinite,
            ),
          ],
        ],
      ),
    );
  }
}
