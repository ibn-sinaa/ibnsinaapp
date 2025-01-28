import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_sizes.dart';

class CustomCheckBox extends StatelessWidget {
  final Function(bool) onChanged;
  final Function()? onTap;
  final bool isChecked;
  final double size;
  final double? verticalPadding;
  final double? horizontalPadding;
  final String? title;
  final TextStyle? titleStyle;
  final Color? titleColor;

  const CustomCheckBox({
    super.key,
    required this.onChanged,
    this.onTap,
    required this.isChecked,
    this.verticalPadding,
    this.horizontalPadding,
    this.title,
    this.size = 23,
    this.titleStyle,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isChecked),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding?.h ?? 0,
          horizontal: horizontalPadding?.w ?? 0.w,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: size.w,
              width: size.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: Colors.white,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: AppSizes.borderWidth.w,
                ),
              ),
              child: Center(
                child: isChecked
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 16.w,
                      )
                    : null,
              ),
            ),
            if (title != null)
              Row(
                children: [
                  SizedBox(
                    width: 12.w,
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Text(
                      title!,
                      style: titleStyle ??
                          TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
