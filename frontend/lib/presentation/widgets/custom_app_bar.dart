import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/utils/app_constants.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/presentation/my_app.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.customTitle,
    this.actions,
    this.leading,
    this.centerTitle,
    this.systemOverlayStyle,
    this.backgroundColor,
  });

  final String? title;
  final Widget? customTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? centerTitle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: customTitle ?? Text(title ?? ''),
      toolbarHeight: getValueForScreenType(
        navigatorKey.currentContext!,
        medium: AppSizes.appBarHeight.h,
        large: (AppSizes.appBarHeight + 20).h,
      ),
      titleTextStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.c01628F,
        fontFamily: AppConstants.fontFamily,
        height: 1.5,
      ),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      leadingWidth: 70.w,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        getValueForScreenType(
          navigatorKey.currentContext!,
          medium: AppSizes.appBarHeight.h,
          large: (AppSizes.appBarHeight + 20).h,
        ),
      );
}
