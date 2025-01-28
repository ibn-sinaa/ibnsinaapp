import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../cubit/category/category_cubit.dart';
import '../../../widgets/custom_shadow_container.dart';

import '../../../../config/locale/language_manager.dart';

class SendQuotationRequestWidget extends StatelessWidget {
  const SendQuotationRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding.w,
            ),
            child: GestureDetector(
              onTap: () {
                AppRouter.pushNamed(context, AppRoutes.sendQuotationRequest);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 14.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radius.r),
                  border: Border.all(
                    color: AppColors.c01628F.withOpacity(0.3),
                    width: AppSizes.borderWidth.w,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            SvgImages.quotationRequest,
                            width: 50.w,
                            height: 42.h,
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: AppSizes.horizontalPadding.w,
                              ),
                              Text(
                                AppStrings.sendQuotationRequest.tr(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CustomShadowContainer(
                      padding: EdgeInsets.all(
                          getValueForScreenType(context, medium: 17, large: 14)
                              .w),
                      child: Transform.rotate(
                        angle: LanguageManager.isEnglish(context) ? pi : 0,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2.5.h),
                          child: SvgPicture.asset(
                            SvgImages.horizontalArrow,
                            width: getValueForScreenType(context,
                                    medium: 10, large: 16)
                                .r,
                            height: getValueForScreenType(context,
                                    medium: 10, large: 16)
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
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
