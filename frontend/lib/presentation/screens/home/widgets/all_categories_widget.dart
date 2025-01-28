import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../cubit/category/category_cubit.dart';
import '../../../../cubit/home_products/home_products_cubit.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/error_widget.dart';

class AllCategoriesWidget extends StatelessWidget {
  const AllCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryLoaded) {
          context.read<HomeProductsCubit>().getHomeData();
        }
      },
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const FetchLoading(
            size: 60,
          );
        } else if (state is CategoryError) {
          return InlineErrorData(
            onTap: () {
              context.read<CategoryCubit>().getCategories();
            },
            message: state.message,
            size: 40,
          );
        } else if (state is CategoryLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalPadding.w,
                ),
                child: Text(
                  AppStrings.allCategories.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                height: 80.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding.w,
                  ),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return GestureDetector(
                      onTap: () {
                        AppRouter.pushNamed(context, AppRoutes.category,
                            arguments: {
                              'name': category.name,
                              'id': category.id,
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        decoration: BoxDecoration(
                          color: AppColors.cF1F5FB,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radius.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              '${category.productCount}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return SizedBox(
                      width: 11.w,
                    );
                  },
                  itemCount: state.categories.length,
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
