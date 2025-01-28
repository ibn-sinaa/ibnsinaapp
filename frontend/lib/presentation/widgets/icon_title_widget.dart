import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';

class IconTitleWidget extends StatelessWidget {
  final String icon;
  final String title;

  const IconTitleWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          width: getValueForScreenType(context, medium: 16.4, large: 18).w,
          height: getValueForScreenType(context, medium: 10, large: 17).h,
        ),
        SizedBox(
          width: 6.w,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).primaryColor,
          ).copyWith(height: 1),
        ),
      ],
    );
  }
}
