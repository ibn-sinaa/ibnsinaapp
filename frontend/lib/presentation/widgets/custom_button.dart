import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/utils/app_constants.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.width,
    this.radius,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.textStyle,
    this.elevation,
    this.side,
  });

  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? elevation;
  final BorderSide? side;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: getValueForScreenType(
                  context,
                  small: 20,
                  medium: 17,
                  large: 20,
                ).h,
                horizontal: 24.w,
              ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: elevation,
          textStyle: textStyle ??
              TextStyle(
                color: Colors.white,
                fontSize:
                    getValueForScreenType(context, small: 19, medium: 17).sp,
                fontWeight: FontWeight.w500,
                fontFamily: AppConstants.fontFamily,
                height: 1.3,
              ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? AppSizes.radius.r),
          ),
          side: side,
        ),
        child: FittedBox(
          child: Text(text),
        ),
      ),
    );
  }
}
