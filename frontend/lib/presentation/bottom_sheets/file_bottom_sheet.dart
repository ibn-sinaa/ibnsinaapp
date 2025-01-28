import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/routes/app_router.dart';
import '../../core/helpers/helper_functions.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_strings.dart';
import 'package:image_picker/image_picker.dart';

class FileBottomSheet extends StatelessWidget {
  final Function(File file) onUpdated;
  final bool uploadOnlyImage;
  final bool showCamera;

  const FileBottomSheet({
    super.key,
    required this.onUpdated,
    this.uploadOnlyImage = true,
    this.showCamera = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 32.w,
        right: 32.w,
        top: 33.h,
        bottom: 47.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            SvgImages.line,
            width: 54.w,
            height: 5.h,
          ),
          SizedBox(
            height: 47.h,
          ),
          Text(
            showCamera
                ? AppStrings.chooseImageSource.tr()
                : AppStrings.attachTheFile.tr(),
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: showCamera ? 57.h : 20.h,
          ),
          if (showCamera)
            _OutlineButton(
              onPressed: () {
                HelperFunctions.pickImage(ImageSource.camera).then((value) {
                  AppRouter.pop(context);
                  value.fold((failure) {
                    HelperFunctions.showToastMessage(context, failure);
                  }, (file) {
                    if (file != null) {
                      onUpdated(file);
                    }
                  });
                });
              },
              color: Theme.of(context).colorScheme.secondary,
              title: AppStrings.camera.tr(),
            ),
          SizedBox(
            height: 24.h,
          ),
          _OutlineButton(
            onPressed: () {
              if (uploadOnlyImage) {
                HelperFunctions.pickImage(ImageSource.gallery).then((value) {
                  AppRouter.pop(context);
                  value.fold((failure) {
                    HelperFunctions.showToastMessage(context, failure);
                  }, (file) {
                    if (file != null) {
                      onUpdated(file);
                    }
                  });
                });
              } else {
                HelperFunctions.pickFiles().then((value) {
                  AppRouter.pop(context);
                  value.fold((failure) {
                    HelperFunctions.showToastMessage(context, failure);
                  }, (files) {
                    if (files.isNotEmpty) {
                      onUpdated(files.first);
                    }
                  });
                });
              }
            },
            color: Theme.of(context).primaryColor,
            title: uploadOnlyImage
                ? AppStrings.gallery.tr()
                : AppStrings.files.tr(),
          ),
        ],
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final Function() onPressed;
  final Color color;
  final String title;

  const _OutlineButton({
    required this.onPressed,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(
            color: color,
          ),
          elevation: 2.r,
          shadowColor: color,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
