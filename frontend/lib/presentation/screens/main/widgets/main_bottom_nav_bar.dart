import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../cubit/main/main_cubit.dart';

import 'main_item.dart';

class MainBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -6.r),
            blurRadius: 6.r,
            color: Theme.of(context).shadowColor.withOpacity(0.7),
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: mainItems
            .map(
              (item) => GestureDetector(
                onTap: () =>
                    context.read<MainCubit>().goToScreenWithIndex(item.index),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        item.icon,
                        width: getValueForScreenType(context,
                                small: 25, medium: 20, large: 28)
                            .r,
                        height: getValueForScreenType(context,
                                small: 25, medium: 20, large: 28)
                            .r,
                        colorFilter: AppColors.colorFilter(
                          item.index == currentIndex
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).unselectedWidgetColor,
                        ),
                      ),
                      SizedBox(
                        height: 8.5.h,
                      ),
                      Text(
                        item.title.tr(),
                        style: TextStyle(
                          fontSize: getValueForScreenType(context,
                                  small: 15, medium: 13, large: 14)
                              .sp,
                          color: item.index == currentIndex
                              ? Theme.of(context).primaryColor
                              : AppColors.c919191,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      if (item.index == currentIndex)
                        SvgPicture.asset(
                          SvgImages.dot,
                          width: 30.w,
                          height: 8.h,
                        ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
