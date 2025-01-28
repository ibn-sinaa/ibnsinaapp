import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import '../../config/themes/app_colors.dart';
import '../../core/utils/app_sizes.dart';

class CustomRadioTile<T> extends StatelessWidget {
  final Function(T value) onChanged;
  final T value;
  final T? groupValue;
  final String title;
  final double? verticalPadding;

  const CustomRadioTile({
    super.key,
    required this.onChanged,
    required this.value,
    required this.groupValue,
    required this.title,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(AppSizes.radius.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding?.h ?? 14.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize:
                    getValueForScreenType(context, small: 18, medium: 16).sp,
                color: AppColors.c2D2F3A,
                height: 1.7,
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Container(
              height: 22.w,
              width: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == groupValue
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.white,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: AppSizes.borderWidth.w,
                ),
              ),
              child: value == groupValue
                  ? Center(
                      child: FittedBox(
                        child: Icon(
                          Icons.check,
                          size: 14.w,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
