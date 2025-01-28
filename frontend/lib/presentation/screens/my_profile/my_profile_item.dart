import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import '../../../config/themes/app_colors.dart';

class MyProfileItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String image;

  const MyProfileItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 17.h,
          horizontal: 18.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.cFAFAFA,
          borderRadius: BorderRadius.circular(9.r),
        ),
        child: Row(
          children: [
            Container(
              height: 32.w,
              width: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.08),
              ),
              child: Center(
                child: SvgPicture.asset(
                  image,
                  width: 16.w,
                  colorFilter: AppColors.colorFilter(
                      Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize:
                    getValueForScreenType(context, small: 16, medium: 14).sp,
                color: AppColors.c2D2F3A,
              ),
            )
          ],
        ),
      ),
    );
  }
}
