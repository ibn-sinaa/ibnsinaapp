import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/app_colors.dart';
import '../../core/utils/app_sizes.dart';
import '../../core/utils/app_strings.dart';

class ErrorData extends StatelessWidget {
  final Function()? onTap;
  final String message;

  const ErrorData({
    super.key,
    this.onTap,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error,
              size: 60.w,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.c2D2F3A,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40.h,
            ),
            OutlinedButton(
              onPressed: onTap,
              child: Text(
                AppStrings.refresh.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InlineErrorData extends StatelessWidget {
  final Function()? onTap;
  final String? message;
  final double size;

  const InlineErrorData({
    super.key,
    this.onTap,
    this.size = 30,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.refresh,
                size: size.w,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            if (message != null) ...[
              SizedBox(
                height: 12.h,
              ),
              Text(
                message!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.c2D2F3A,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
