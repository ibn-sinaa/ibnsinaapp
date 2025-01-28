import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';

class IntroDescription extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> fadeInOutAnimation;
  final String description;

  const IntroDescription({
    super.key,
    required this.description,
    required this.animationController,
    required this.fadeInOutAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154.h,
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 10.h,
      ),
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8.r),
            blurRadius: 8.r,
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: Center(
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Opacity(
                opacity: fadeInOutAnimation.value,
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.c2D2F3A,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }),
      ),
    );
  }
}
