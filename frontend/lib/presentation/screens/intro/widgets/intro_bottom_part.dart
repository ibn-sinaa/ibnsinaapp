import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../widgets/custom_dots.dart';

class IntroBottomPart extends StatelessWidget {
  final Function() startNow;
  final Function() nextPage;
  final int currentIndex;
  final bool isLastPage;
  final int length;

  const IntroBottomPart({
    super.key,
    required this.startNow,
    required this.nextPage,
    required this.currentIndex,
    required this.isLastPage,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomDots(
          currentIndex: currentIndex,
          length: length,
          isCircle: false,
          activeHeight: 23,
          activeWidth: 4.49,
          unactiveHeight: 10.15,
          unactiveWidth: 4.49,
        ),
        SizedBox(
          height: 24.h,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            width: isLastPage ? 200.w : 60.w,
            height: 60.w,
            child: FloatingActionButton.extended(
              onPressed: isLastPage ? startNow : nextPage,
              label: isLastPage
                  ? Text(
                      AppStrings.startNow.tr(),
                      style: TextStyle(
                        fontSize: getValueForScreenType(
                          context,
                          small: 19,
                          medium: 16,
                        ).sp,
                      ).copyWith(height: 1.5),
                    )
                  : SvgPicture.asset(
                      SvgImages.horizontalArrow,
                      colorFilter: AppColors.colorFilter(Colors.white),
                      width: 12.w,
                    ),
            ),
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
      ],
    );
  }
}
