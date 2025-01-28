import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';

class AuthBottomPart extends StatelessWidget {
  final Function() onTap;
  final String text1;
  final String text2;

  const AuthBottomPart({
    super.key,
    required this.onTap,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cF5F5F5,
        borderRadius: BorderRadius.circular(AppSizes.radius.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.c848484,
            ),
          ),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
            ),
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.c2D2F3A,
                height: 0.9,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
