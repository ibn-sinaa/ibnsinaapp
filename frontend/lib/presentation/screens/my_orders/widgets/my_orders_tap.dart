import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import '../../../../config/themes/app_colors.dart';

import '../../../../cubit/my_orders/my_orders_cubit.dart';

class MyOrdersTap extends StatelessWidget {
  final int selectedTapId;
  final int tapId;
  final String title;
  final OrderType orderType;

  const MyOrdersTap({
    super.key,
    required this.selectedTapId,
    required this.tapId,
    required this.title,
    required this.orderType,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          switch (orderType) {
            case OrderType.product:
              context.read<MyOrdersCubit>().getProductOrders(tapId: tapId);
            case OrderType.paper:
              context.read<MyOrdersCubit>().getPaperOrders(tapId: tapId);
            case OrderType.media:
              context.read<MyOrdersCubit>().getMediaOrders(tapId: tapId);
              break;
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(
              top: getValueForScreenType(context, medium: 9, large: 11).h,
              bottom: getValueForScreenType(context, medium: 6, large: 8).h),
          decoration: BoxDecoration(
            color: tapId == selectedTapId
                ? Theme.of(context).colorScheme.secondary
                : AppColors.c37474F,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize:
                  getValueForScreenType(context, medium: 14, large: 15).sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.7,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
