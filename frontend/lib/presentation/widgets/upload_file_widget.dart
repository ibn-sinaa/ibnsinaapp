import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/locale/language_manager.dart';
import '../../config/themes/app_colors.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_sizes.dart';
import '../../core/utils/app_strings.dart';
import '../bottom_sheets/file_bottom_sheet.dart';
import 'circle_icon.dart';

class UploadFileWidget extends StatefulWidget {
  final Function(File? file) onUpload;

  const UploadFileWidget({super.key, required this.onUpload});

  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  File? _design;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.attachTheFile.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(
            height: 22.h,
          ),
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40.r),
                      ),
                    ),
                    isScrollControlled: true,
                    constraints: BoxConstraints(minWidth: double.maxFinite),
                    builder: (context) {
                      return FileBottomSheet(
                        uploadOnlyImage: false,
                        onUpdated: (design) {
                          setState(() {
                            _design = design;
                            widget.onUpload(File(design.path));
                          });
                        },
                        showCamera: false,
                      );
                    },
                  );
                },
                child: Container(
                  height: 186.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _design != null
                        ? AppColors.c0CA000.withOpacity(0.05)
                        : Colors.white,
                    border: Border.all(
                      color: _design != null
                          ? AppColors.c0CA000
                          : Theme.of(context).primaryColor,
                      width: AppSizes.borderWidth.w,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppSizes.radius.r,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: 102.h,
                        width: 142.w,
                        child: SvgPicture.asset(
                          SvgImages.uploadFile,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        _design != null
                            ? AppStrings.fileUploaded.tr()
                            : AppStrings.uploadFile.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: _design != null
                              ? AppColors.c0CA000
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (_design != null)
                Align(
                  alignment: LanguageManager.isEnglish(context)
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: CircleIcon(
                    onPressed: () {
                      setState(() {
                        _design = null;
                        widget.onUpload(null);
                      });
                    },
                    icon: Icons.delete_forever_sharp,
                    size: 24,
                    radius: 20,
                    color: AppColors.c0CA000,
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
