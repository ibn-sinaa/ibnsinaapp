import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';

class CustomShadowContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? radius;
  final Color? bgColor;
  final bool enableShadow;

  const CustomShadowContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.radius,
    this.bgColor,
    this.enableShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ??
          EdgeInsets.only(
            left: 12.w,
            right: 7.w,
            bottom: getValueForScreenType(context, medium: 7, large: 12).h,
            top: getValueForScreenType(context, medium: 10, large: 15).h,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius?.r ?? 9.r),
        color: bgColor ?? Colors.white,
        boxShadow: enableShadow
            ? [
                BoxShadow(
                  blurRadius: 10.r,
                  color: Theme.of(context).shadowColor,
                )
              ]
            : null,
      ),
      child: child,
    );
  }
}
