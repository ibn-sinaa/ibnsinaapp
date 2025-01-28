import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/app_colors.dart';
import '../../core/utils/app_sizes.dart';

class NotificationDetailsDialog extends StatelessWidget {
  final String title;
  final String message;

  const NotificationDetailsDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 250),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSizes.radius.r,
              ),
            ),
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    AppSizes.radius.r,
                  ),
                ),
                color: AppColors.c01628F,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.c37474F,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
