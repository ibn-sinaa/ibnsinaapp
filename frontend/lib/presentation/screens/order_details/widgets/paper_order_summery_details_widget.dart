import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';
import 'package:ibn_sina/data/models/paper_order_model.dart';
import 'package:ibn_sina/presentation/widgets/row_item.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_images.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/custom_shadow_container.dart';
import '../../../widgets/icon_title_widget.dart';

class PaperOrderSummeryDetailsWidget extends StatelessWidget {
  final List<PaperItemModel> paperItems;
  final OptionDataModel paperColor;
  final int pageCount;
  final int copiesCount;

  const PaperOrderSummeryDetailsWidget({
    super.key,
    required this.paperItems,
    required this.paperColor,
    required this.pageCount,
    required this.copiesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.orderSummary.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        CustomShadowContainer(
          padding: EdgeInsets.zero,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 16.h,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RowItem(
                      title: AppStrings.printingColor.tr(),
                      content:
                          '${paperColor.name} (${HelperFunctions.getPrice(paperColor.price * pageCount * copiesCount)})',
                    ),
                  ],
                );
              } else {
                return _Item(paperItem: paperItems[index - 1]);
              }
            },
            separatorBuilder: (_, __) {
              return Divider(
                height: 20.h,
              );
            },
            itemCount: paperItems.length + 1,
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.paperItem});

  final PaperItemModel paperItem;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedImage(
          imageUrl: paperItem.paperOptionData.image,
          height: 59,
          width: 59,
          memCacheHeight: 59.w.cacheSize(context),
          memCacheWidth: 59.w.cacheSize(context),
          radius: 9,
        ),
        SizedBox(
          width: 11.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowItem(
                title: paperItem.paperOption.name,
                content: paperItem.paperOptionData.name,
              ),
              SizedBox(
                height: 8.h,
              ),
              IconTitleWidget(
                icon: SvgImages.money,
                title: HelperFunctions.getPrice(
                  paperItem.optionCost,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
