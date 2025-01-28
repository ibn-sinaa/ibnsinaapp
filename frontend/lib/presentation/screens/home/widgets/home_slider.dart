import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import '../../../../core/api/status_code.dart';
import '../../../../core/helpers/helper_functions.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../cubit/category/category_cubit.dart';
import '../../../../cubit/home_slider/home_slider_cubit.dart';
import '../../../../data/models/image_model.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/custom_dots.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/error_widget.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = getValueForScreenType(context, small: 200, medium: 180).h;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding.w,
        vertical: AppSizes.verticalPadding.h,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radius.r),
        child: SizedBox(
          height: height,
          child: BlocConsumer<HomeSliderCubit, HomeSliderState>(
            listener: (context, state) {
              if (state is HomeSliderLoaded) {
                context.read<CategoryCubit>().getCategories();
              }
              if (state is HomeSliderError) {
                if (state.statusCode == StatusCode.unauthorized) {
                  HelperFunctions.showToastMessage(
                    context,
                    AppStrings.yourAccountHasBeenBlockedByTheAdministration
                        .tr(),
                  );
                  AppRouter.pushReplacementNamed(context, AppRoutes.signIn);
                }
              }
            },
            builder: (context, state) {
              if (state is HomeSliderLoading) {
                return const FetchLoading(
                  size: 60,
                );
              } else if (state is HomeSliderError) {
                return InlineErrorData(
                  onTap: () {
                    context.read<HomeSliderCubit>().getHomeSliders();
                  },
                  message: state.message,
                  size: 40,
                );
              } else if (state is HomeSliderLoaded) {
                return Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: height,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        onPageChanged: ((index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        }),
                      ),
                      items: state.sliders.map((slider) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                AppRouter.pushNamed(
                                  context,
                                  AppRoutes.imageViewer,
                                  arguments: ImageModel(
                                    images: state.sliders
                                        .map((slider) => slider.image)
                                        .toList(),
                                    index: _currentIndex,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.cF5F5F5,
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.radius.r),
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.radius.r),
                                  child: CachedImage(
                                    height: height,
                                    width: double.maxFinite,
                                    memCacheHeight: getValueForScreenType(
                                            context,
                                            small: 180,
                                            medium: 160)
                                        .h
                                        .cacheSize(context),
                                    imageUrl: slider.image,
                                    enableTap: false,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Positioned(
                      left: 0.w,
                      right: 0.w,
                      bottom: 0.h,
                      child: CustomDots(
                        currentIndex: _currentIndex,
                        length: state.sliders.length,
                        activeColor: Colors.white,
                        disabledColor: Colors.white70,
                        bgColor: AppColors.c2D2F3A.withOpacity(0.4),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        activeHeight: 12,
                        activeWidth: 12,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
