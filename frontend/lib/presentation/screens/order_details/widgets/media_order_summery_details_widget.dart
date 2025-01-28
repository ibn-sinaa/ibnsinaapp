import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/data/models/media_order_model.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/printing_size_text.dart';
import 'package:ibn_sina/presentation/widgets/downloading_file_widget.dart';
import 'package:ibn_sina/presentation/widgets/row_item.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_images.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/custom_shadow_container.dart';
import '../../../widgets/icon_title_widget.dart';

class MediaOrderSummeryDetailsWidget extends StatelessWidget {
  final List<MediaItemModel> mediaItems;

  const MediaOrderSummeryDetailsWidget({
    super.key,
    required this.mediaItems,
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
              return _Item(mediaItem: mediaItems[index]);
            },
            separatorBuilder: (_, __) {
              return Divider(
                height: 20.h,
              );
            },
            itemCount: mediaItems.length,
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.mediaItem});

  final MediaItemModel mediaItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowItem(
          title: AppStrings.designFile.tr(),
          customContent: Expanded(
            child: DownloadingFileWidget(fileUrl: mediaItem.fileUploaded),
          ),
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        Divider(
          indent: AppSizes.horizontalPadding.w,
          endIndent: AppSizes.horizontalPadding.w,
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImage(
              imageUrl: mediaItem.material.image,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RowItem(
                          title: AppStrings.materialType.tr(),
                          content: mediaItem.material.name,
                        ),
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      IconTitleWidget(
                        icon: SvgImages.money,
                        title: HelperFunctions.getPrice(
                          mediaItem.material.price,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  PrintingSizeText(
                    height: mediaItem.height,
                    width: mediaItem.width,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  RowItem(
                    title: AppStrings.copiesCount.tr(),
                    content: '${mediaItem.copyNumbers}',
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  RowItem(
                    title: AppStrings.total.tr(),
                    customContent: IconTitleWidget(
                      icon: SvgImages.money,
                      title: HelperFunctions.getPrice(
                        mediaItem.totalPrice,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
