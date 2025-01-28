import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';

import '../../../config/themes/app_colors.dart';

class SettingItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String icon;

  const SettingItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width:
                      getValueForScreenType(context, medium: 27, large: 40).w,
                  height:
                      getValueForScreenType(context, medium: 33, large: 45).h,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          FittedBox(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.c2D2F3A,
              ),
            ),
          )
        ],
      ),
    );
  }
}
