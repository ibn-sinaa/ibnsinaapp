import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/presentation/widgets/favorite_icon.dart';
import '../../config/locale/language_manager.dart';
import '../../config/routes/app_router.dart';
import '../../config/routes/app_routes.dart';
import '../../config/themes/app_colors.dart';
import '../../core/utils/app_strings.dart';
import '../../data/models/product/product_model.dart';
import 'cached_image.dart';
import 'price_text.dart';
import 'row_item.dart';

class ProductWidget extends StatefulWidget {
  final ProductModel productModel;
  final bool expandTitle;

  const ProductWidget({
    super.key,
    required this.productModel,
    this.expandTitle = true,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _goToProductDetailsScreen(context);
      },
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 164.h,
              child: Stack(
                children: [
                  CachedImage(
                    imageUrl: widget.productModel.mainImage,
                    height: 164,
                    memCacheHeight: 164.h.cacheSize(context),
                    width: double.maxFinite,
                    radius: 9,
                    enableBottomLeftRadius: false,
                    enableBottomRightRadius: false,
                    enableTap: false,
                  ),
                  Align(
                    alignment: LanguageManager.isEnglish(context)
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 9.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: LanguageManager.isEnglish(context)
                            ? BorderRadius.only(topRight: Radius.circular(9.r))
                            : BorderRadius.only(topLeft: Radius.circular(9.r)),
                      ),
                      child: PriceText(
                        price: widget.productModel.price,
                        offerPrice: widget.productModel.offerPrice,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(
                      0.95,
                      -0.9,
                    ),
                    child: SafeArea(
                      child: FavoriteIcon(
                        productModel: widget.productModel,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 9.h,
                left: 9.w,
                right: 9.w,
                bottom: widget.expandTitle ? 9.h : 0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.productModel.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                          maxLines: widget.expandTitle ? 3 : 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        '${AppStrings.quantity.tr()} ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.c989898,
                        ),
                      ),
                      Text(
                        widget.productModel.startAmount.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    height: widget.expandTitle
                        ? null
                        : getValueForScreenType(context,
                                small: 115, medium: 85, large: 115)
                            .h,
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      thickness:
                          getValueForScreenType(context, medium: 3, large: 4).r,
                      child: ListView.separated(
                        controller: _scrollController,
                        shrinkWrap: widget.expandTitle,
                        physics: widget.expandTitle
                            ? const NeverScrollableScrollPhysics()
                            : AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final defaultOption =
                              widget.productModel.defaultOptions[index];
                          return RowItem(
                            title: defaultOption.key,
                            content: defaultOption.value,
                            maxLines: 1,
                          );
                        },
                        separatorBuilder: (_, __) {
                          return SizedBox(height: 9.h);
                        },
                        itemCount: widget.productModel.defaultOptions.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!widget.expandTitle) const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                left: 9.w,
                right: 9.w,
                bottom: 9.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _goToProductDetailsScreen(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.0784),
                      padding: EdgeInsets.symmetric(
                        vertical:
                            getValueForScreenType(context, medium: 3, large: 16)
                                .h,
                        horizontal: 11.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(
                      AppStrings.moreDetails.tr(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _goToProductDetailsScreen(BuildContext context) {
    AppRouter.pushNamed(
      context,
      AppRoutes.productDetails,
      arguments: {
        'productId': widget.productModel.id,
        'title': widget.productModel.title,
      },
    );
  }
}
