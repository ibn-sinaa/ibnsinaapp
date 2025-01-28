import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../cubit/category/category_cubit.dart';
import '../../../../cubit/home_slider/home_slider_cubit.dart';

import '../../../../core/utils/app_sizes.dart';
import '../../../../cubit/home_products/home_products_cubit.dart';
import '../../../../cubit/refresh/refresh_cubit.dart';
import '../../../../cubit/search/search_cubit.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/search_result_widget.dart';
import '../../../widgets/search_text_field.dart';
import '../horizontal_products_lists.dart';
import 'all_categories_widget.dart';
import 'send_quotation_request_widget.dart';
import 'home_slider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, searchState) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeSliderCubit>().getHomeSliders();
            context.read<CategoryCubit>().resetState();
            context.read<HomeProductsCubit>().resetState();
          },
          child: CustomScrollView(
            primary: true,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSizes.verticalPadding.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.horizontalPadding.w,
                      ),
                      child: BlocBuilder<RefreshCubit, bool>(
                        builder: (context, _) {
                          return SearchTextField(
                            onChanged: (value) {
                              context
                                  .read<SearchCubit>()
                                  .searchForProduct(value);
                            },
                          );
                        },
                      ),
                    ),
                    if (!searchState.showSearchResult) ...[
                      const HomeSlider(),
                      SizedBox(
                        height: 13.h,
                      ),
                      const AllCategoriesWidget(),
                      SizedBox(
                        height: 21.h,
                      ),
                      const SendQuotationRequestWidget(),
                      SizedBox(
                        height: 24.h,
                      ),
                    ] else
                      SizedBox(
                        height: AppSizes.verticalPadding.h,
                      ),
                  ],
                ),
              ),
              searchState.showSearchResult
                  ? SearchResultWidget(
                      searchState: searchState,
                    )
                  : BlocBuilder<HomeProductsCubit, HomeProductsState>(
                      builder: (context, state) {
                        if (state is HomeProductsLoading) {
                          return const SliverToBoxAdapter(
                            child: FetchLoading(
                              size: 60,
                            ),
                          );
                        } else if (state is HomeProductsError) {
                          return SliverToBoxAdapter(
                            child: InlineErrorData(
                              onTap: () {
                                context.read<HomeProductsCubit>().getHomeData();
                              },
                              message: state.message,
                              size: 40,
                            ),
                          );
                        } else if (state is HomeProductsLoaded) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    HorizontalProductsLists(
                                      homeModel: state.homeData[index],
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                  ],
                                );
                              },
                              childCount: state.homeData.length,
                            ),
                          );
                        }
                        return const SliverToBoxAdapter(
                          child: SizedBox.shrink(),
                        );
                      },
                    ),
              SliverPadding(
                padding: EdgeInsets.only(
                  bottom: AppSizes.verticalPadding.h,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
