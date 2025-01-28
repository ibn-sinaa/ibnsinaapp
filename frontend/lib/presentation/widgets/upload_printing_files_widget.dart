import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';

class UploadPrintingFilesWidget extends StatelessWidget {
  const UploadPrintingFilesWidget({
    super.key,
    required this.onUploaded,
    required this.title,
    this.allowMultiple = false,
    this.allowAllExtensions = false,
  });

  final void Function(List<File> files) onUploaded;
  final bool allowMultiple;
  final bool allowAllExtensions;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding.w,
        vertical: AppSizes.verticalPadding.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius.r),
        border: Border.all(
          color: AppColors.c707070,
          width: AppSizes.borderWidth.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            SvgImages.uploadFile1,
            height: 100.h,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.c2D2F3A,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(
            onPressed: () {
              HelperFunctions.pickFiles(
                context: context,
                allowedExtensions: allowAllExtensions ? null : ['pdf'],
                allowMultiple: allowMultiple,
              ).then((value) {
                value.fold((failure) {
                  HelperFunctions.showToastMessage(context, failure);
                }, (files) {
                  if (files.isNotEmpty) {
                    onUploaded(files);
                  }
                });
              });
            },
            backgroundColor: AppColors.c2D2F3A,
            radius: 8.r,
            padding: EdgeInsets.symmetric(
              vertical: getValueForScreenType(context, small: 15, medium: 12).h,
              horizontal: 24.w,
            ),
            text: AppStrings.browseFiles.tr(),
          ),
        ],
      ),
    );
  }
}
