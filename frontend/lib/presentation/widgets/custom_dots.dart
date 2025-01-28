import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/app_colors.dart';

class CustomDots extends StatelessWidget {
  final int currentIndex;
  final int length;
  final Color? activeColor;
  final Color? disabledColor;
  final Color? bgColor;
  final double? margin;
  final double? height;
  final double activeHeight;
  final double activeWidth;
  final double unactiveHeight;
  final double unactiveWidth;
  final double radius;
  final bool isCircle;
  final EdgeInsets? padding;

  const CustomDots({
    super.key,
    required this.currentIndex,
    required this.length,
    this.activeColor,
    this.disabledColor,
    this.bgColor,
    this.margin,
    this.height,
    this.activeHeight = 10,
    this.activeWidth = 10,
    this.unactiveHeight = 10,
    this.unactiveWidth = 10,
    this.radius = 10,
    this.isCircle = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];
    for (var index = 0; index < length; index++) {
      double dotHeight =
          currentIndex == index ? activeHeight.h : unactiveHeight.h;
      double dotWidth = currentIndex == index ? activeWidth.w : unactiveWidth.w;

      dots.add(
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 200,
          ),
          height: dotHeight,
          width: dotWidth,
          margin: EdgeInsets.symmetric(
            horizontal: margin?.w ?? 5.w,
          ),
          decoration: BoxDecoration(
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle ? null : BorderRadius.circular(radius.r),
            color: index == currentIndex
                ? activeColor ?? Theme.of(context).colorScheme.secondary
                : disabledColor ?? AppColors.cE2DFDF,
          ),
        ),
      );
    }
    return Center(
      child: Container(
        color: bgColor,
        width: double.infinity,
        padding: padding,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dots.map((dot) => dot).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
