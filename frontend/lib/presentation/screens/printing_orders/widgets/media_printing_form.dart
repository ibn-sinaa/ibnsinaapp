import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/cubit/media_printing/media_printing_cubit.dart';
import 'package:ibn_sina/data/models/media_form_model.dart';
import 'package:ibn_sina/data/models/option_model/option_model.dart';
import 'package:ibn_sina/presentation/screens/printing_orders/widgets/media_printing_size_widget.dart';
import 'package:ibn_sina/presentation/screens/printing_orders/widgets/copies_count_widget.dart';
import 'package:ibn_sina/presentation/widgets/option_widget.dart';
import 'package:ibn_sina/presentation/widgets/upload_printing_files_widget.dart';
import 'package:ibn_sina/presentation/widgets/uploaded_printing_file_field.dart';

class MediaPrintingForm extends StatelessWidget {
  const MediaPrintingForm({
    super.key,
    required this.form,
    required this.materialType,
    required this.length,
  });

  final MediaFormModel form;
  final OptionModel materialType;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        form.file == null
            ? UploadPrintingFilesWidget(
                onUploaded: (files) {
                  context.read<MediaPrintingCubit>().generateForms(files);
                },
                allowMultiple: true,
                allowAllExtensions: true,
                title: AppStrings.uploadFiles.tr(),
              )
            : UploadedPrintingFileField(
                fileNameController: form.controller,
                file: form.file!,
                onFileChanged: () => _onFileChanged(context),
              ),
        SizedBox(
          height: 16.h,
        ),
        OptionWidget(
          option: materialType,
          onTap: (serviceType) {
            context
                .read<MediaPrintingCubit>()
                .changeMaterialType(form, serviceType);
          },
          value: form.materialType,
          showDivider: false,
        ),
        MediaPrintingSizeWidget(
          onHeightChanded: (int height) {
            context.read<MediaPrintingCubit>().changePaperHeight(form, height);
          },
          onWidthChanded: (int width) {
            context.read<MediaPrintingCubit>().changePaperWidth(form, width);
          },
          width: form.width,
          height: form.height,
        ),
        SizedBox(
          height: 24.h,
        ),
        CopiesCountWidget(
          onChanged: (count) {
            context.read<MediaPrintingCubit>().changeCopiesCount(form, count);
          },
          initialCount: form.copiesCount,
        ),
        if (length > 1) ...[
          SizedBox(
            height: 16.h,
          ),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: (2 * AppSizes.horizontalPadding).w,
            ),
            child: OutlinedButton(
              onPressed: () {
                context.read<MediaPrintingCubit>().deleteForm(form);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.cEF5350,
                side: BorderSide(color: AppColors.cEF5350),
              ),
              child: Text(
                AppStrings.delete.tr(),
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _onFileChanged(BuildContext context) {
    HelperFunctions.pickFiles().then((value) {
      value.fold((failure) {
        HelperFunctions.showToastMessage(context, failure);
      }, (files) {
        if (files.isNotEmpty) {
          context.read<MediaPrintingCubit>().changeFile(form, files.first);
          form.controller.text = HelperFunctions.getFileName(
            files.first.path,
          );
        }
      });
    });
  }
}
