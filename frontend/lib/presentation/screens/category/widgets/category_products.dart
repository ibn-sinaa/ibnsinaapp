import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/presentation/widgets/no_data.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/enums.dart';
import '../../../../cubit/products/products_cubit.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/product_widget.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state.productsRequest == RequestState.error) {
          HelperFunctions.showToastMessage(context, state.message);
        }
      },
      builder: (context, state) {
        if (state.subCategoryRequest == RequestState.loading) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 170.h),
              child: const FetchLoading(),
            ),
          );
        } else if (state.subCategoryRequest == RequestState.error) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 130.h),
              child: ErrorData(
                onTap: () {
                  context.read<ProductsCubit>().getSubCategoryProducts();
                },
                message: state.message,
              ),
            ),
          );
        } else if (state.subCategoryRequest == RequestState.loaded) {
          return state.products.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: NoData(
                      title: AppStrings.noProducts.tr(),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.horizontalPadding.w,
                            ),
                            child: ProductWidget(
                              productModel: state.products[index],
                            ),
                          ),
                          SizedBox(
                            height: 13.5.h,
                          ),
                          if (state.productsRequest == RequestState.loading &&
                              index == state.products.length - 1)
                            const InlineLoading()
                        ],
                      );
                    },
                    childCount: state.products.length,
                  ),
                );
        }
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}
