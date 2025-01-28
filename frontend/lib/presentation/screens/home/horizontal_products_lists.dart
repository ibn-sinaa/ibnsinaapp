import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';

import '../../../config/locale/language_manager.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/app_routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../data/models/home_model.dart';
import '../../widgets/no_data.dart';
import '../../widgets/product_widget.dart';

class HorizontalProductsLists extends StatelessWidget {
  final HomeModel homeModel;

  const HorizontalProductsLists({
    super.key,
    required this.homeModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding.w,
          ),
          child: Row(
            children: [
              Text(
                homeModel.category.name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  AppRouter.pushNamed(context, AppRoutes.category, arguments: {
                    'name': homeModel.category.name,
                    'id': homeModel.category.id,
                  });
                },
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  children: [
                    Text(
                      AppStrings.showAll.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.c2D2F3A,
                        height: LanguageManager.isEnglish(context) ? 1.5 : 1,
                      ),
                    ),
                    SizedBox(
                      width: 6.72.w,
                    ),
                    Transform.rotate(
                      angle: LanguageManager.isEnglish(context) ? pi : 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              LanguageManager.isEnglish(context) ? 0 : 2.5.h,
                        ),
                        child: SvgPicture.asset(
                          SvgImages.horizontalArrow,
                          width: getValueForScreenType(context,
                                  medium: 10, large: 15)
                              .r,
                          height: getValueForScreenType(context,
                                  medium: 10, large: 15)
                              .r,
                          colorFilter: AppColors.colorFilter(
                            Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: getValueForScreenType(context,
                  small: 375, medium: 345, large: 395)
              .h,
          child: homeModel.products.isEmpty
              ? NoData(
                  title: AppStrings.noProducts.tr(),
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding.w,
                  ),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 400.w,
                      child: ProductWidget(
                        productModel: homeModel.products[index],
                        expandTitle: false,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return SizedBox(
                      width: 10.59.w,
                    );
                  },
                  itemCount: homeModel.products.length,
                ),
        ),
      ],
    );
  }
}
