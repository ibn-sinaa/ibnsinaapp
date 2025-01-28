import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/config/locale/language_manager.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onTap;
  final String icon;
  final Color? bgColor;
  final Color? iconColor;
  final double? size;
  final double? bottomPadding;

  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.bgColor,
    this.iconColor,
    this.size,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom:
            bottomPadding?.h ?? (LanguageManager.isEnglish(context) ? 0 : 10.h),
      ),
      child: IconButton(
        onPressed: onTap,
        iconSize: 40.w,
        icon: Container(
          height: 40.w,
          width: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor ??
                Theme.of(context).colorScheme.secondary.withOpacity(0.0824),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              height: size?.w ?? 20.w,
              width: size?.w ?? 20.w,
              colorFilter:
                  iconColor == null ? null : AppColors.colorFilter(iconColor!),
            ),
          ),
        ),
      ),
    );
  }
}
