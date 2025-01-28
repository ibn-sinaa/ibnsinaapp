import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';

import '../../../config/locale/language_manager.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/utils/app_sizes.dart';

class CustomDropDown<T> extends StatelessWidget {
  final String? hintText;
  final List<T> items;
  final Widget Function(T value) builder;
  final String? title;
  final T? value;
  final double? width;
  final void Function(T? value)? onChanged;
  final bool enabled;
  final bool enableUnderLine;
  final bool enableOutlineBorder;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final Color? buttonColor;
  final Color? menuColor;
  final bool enableLable;
  final double lableSize;
  final bool isExpanded;
  final double buttonRadius;
  final double menuRadius;
  final double horizontalPadding;
  final Color? iconColor;
  final TextStyle? hintStyle;

  const CustomDropDown({
    super.key,
    this.hintText,
    required this.items,
    required this.builder,
    this.title,
    this.value,
    this.width,
    this.onChanged,
    this.enabled = true,
    this.enableUnderLine = true,
    this.enableOutlineBorder = false,
    this.padding,
    this.icon,
    this.buttonColor,
    this.menuColor,
    this.enableLable = true,
    this.lableSize = 14,
    this.isExpanded = true,
    this.buttonRadius = AppSizes.radius,
    this.menuRadius = AppSizes.radius,
    this.horizontalPadding = 12,
    this.iconColor,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enabled,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: enableLable
                  ? (value != null)
                      ? 9.h
                      : 0
                  : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
                Container(
                  width: width?.w,
                  padding: enableOutlineBorder
                      ? padding ??
                          EdgeInsets.only(
                            left: LanguageManager.isEnglish(context)
                                ? horizontalPadding.w
                                : 2.w,
                            right: LanguageManager.isEnglish(context)
                                ? 2.w
                                : horizontalPadding.w,
                            top: getValueForScreenType(context,
                                    small: 0, medium: 3, large: 14)
                                .h,
                            bottom: getValueForScreenType(context,
                                    small: 0, medium: 3, large: 14)
                                .h,
                          )
                      : EdgeInsets.zero,
                  decoration: enableOutlineBorder || buttonColor != null
                      ? BoxDecoration(
                          color: buttonColor ?? Colors.white,
                          border: Border.all(
                            color: buttonColor ?? AppColors.c707070,
                            width: AppSizes.borderWidth.r,
                          ),
                          borderRadius: BorderRadius.circular(buttonRadius.r),
                        )
                      : null,
                  child: DropdownButton<T>(
                    isExpanded: isExpanded,
                    dropdownColor: menuColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(menuRadius.r),
                    underline: enableUnderLine
                        ? const Divider()
                        : const SizedBox.shrink(),
                    icon: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                      ),
                      child: icon ??
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: iconColor ?? AppColors.c989898,
                            size: 30.w,
                          ),
                    ),
                    iconSize: 30.w,
                    value: value,
                    hint: hintText == null
                        ? null
                        : Text(
                            hintText!,
                            style: hintStyle ??
                                TextStyle(
                                  fontSize: getValueForScreenType(context,
                                          small: 16, medium: 14)
                                      .sp,
                                  color: AppColors.c848484,
                                ),
                          ),
                    items: items
                        .map(
                          (item) => DropdownMenuItem<T>(
                            value: item,
                            child: builder(item),
                          ),
                        )
                        .toList(),
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
          if (value != null && enableLable)
            Positioned(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                        getValueForScreenType(context, small: 50, medium: 45)
                            .w),
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.r),
                  ),
                ),
                child: Text(
                  hintText!,
                  style: TextStyle(
                    fontSize:
                        getValueForScreenType(context, medium: 12, large: 11)
                            .sp,
                    color: AppColors.c848484,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
