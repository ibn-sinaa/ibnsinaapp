import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';
import 'package:ibn_sina/presentation/widgets/custom_shadow_container.dart';
import 'package:ibn_sina/presentation/widgets/downloading_file_widget.dart';
import 'package:ibn_sina/presentation/widgets/row_item.dart';

class PaperInfoDetailsWidget extends StatelessWidget {
  const PaperInfoDetailsWidget({
    super.key,
    required this.copiesCount,
    required this.pageCount,
    required this.paperColor,
    required this.deliveryType,
    required this.fileUploaded,
  });

  final int copiesCount;
  final int pageCount;
  final OptionDataModel paperColor;
  final DeliveryType deliveryType;
  final String fileUploaded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.mainInfo.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomShadowContainer(
          padding: EdgeInsets.symmetric(
            horizontal: 7.w,
            vertical: 12.h,
          ),
          child: Column(
            children: [
              RowItem(
                title: AppStrings.designFile.tr(),
                customContent: Expanded(
                  child: DownloadingFileWidget(fileUrl: fileUploaded),
                ),
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              const Divider(),
              RowItem(
                title: AppStrings.printingColor.tr(),
                content: paperColor.name,
              ),
              const Divider(),
              RowItem(
                title: AppStrings.pageCount.tr(),
                content: '($pageCount)',
              ),
              const Divider(),
              RowItem(
                title: AppStrings.copiesCount.tr(),
                content: '($copiesCount)',
              ),
              const Divider(),
              RowItem(
                title: AppStrings.deliveryType.tr(),
                content: deliveryType.title.tr(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
