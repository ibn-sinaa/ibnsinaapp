import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';

import '../../../../core/utils/app_strings.dart';

class IntroSkip extends StatelessWidget {
  final Function() onTap;

  const IntroSkip({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        children: [
          CustomButton(
            onPressed: onTap,
            backgroundColor: Colors.white,
            radius: 50.r,
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: getValueForScreenType(context, small: 3, medium: 0).h,
            ),
            foregroundColor: Theme.of(context).colorScheme.secondary,
            text: AppStrings.skip.tr(),
          ),
        ],
      ),
    );
  }
}
