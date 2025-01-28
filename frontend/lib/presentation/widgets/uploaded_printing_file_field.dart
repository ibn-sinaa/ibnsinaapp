import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/presentation/widgets/custom_icon_button.dart';
import 'package:ibn_sina/presentation/widgets/custom_text_field.dart';

class UploadedPrintingFileField extends StatelessWidget {
  const UploadedPrintingFileField({
    super.key,
    required this.fileNameController,
    required this.file,
    this.pageCount,
    required this.onFileChanged,
  });
  final TextEditingController fileNameController;
  final File file;
  final int? pageCount;
  final VoidCallback onFileChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextField(
                controller: fileNameController,
                enabled: false,
              ),
              if (pageCount != null) ...[
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  '${AppStrings.pageCount.tr()}: ($pageCount)',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
        CustomIconButton(
          onTap: onFileChanged,
          icon: SvgImages.uploadFile2,
          iconColor: Theme.of(context).colorScheme.primary,
        ),
        CustomIconButton(
          onTap: () {
            HelperFunctions.openAnyFile(context, file);
          },
          size: 13.w,
          icon: SvgImages.showPassword,
        ),
      ],
    );
  }
}
