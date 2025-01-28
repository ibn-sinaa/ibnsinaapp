import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_sizes.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/enums.dart';
import '../../cubit/search/search_cubit.dart';
import 'custom_loading.dart';
import 'error_widget.dart';
import 'no_data.dart';
import 'product_widget.dart';

class SearchResultWidget extends StatelessWidget {
  final SearchState searchState;

  const SearchResultWidget({
    super.key,
    required this.searchState,
  });

  @override
  Widget build(BuildContext context) {
    if (searchState.requestState == RequestState.loading) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: const FetchLoading(
            size: 60,
          ),
        ),
      );
    } else if (searchState.requestState == RequestState.error) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: InlineErrorData(
            onTap: () {
              context.read<SearchCubit>().searchForProduct();
            },
            message: searchState.message,
            size: 40,
          ),
        ),
      );
    } else if (searchState.requestState == RequestState.loaded) {
      return searchState.products.isEmpty
          ? SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 100.h),
                child: NoData(
                  title: AppStrings.noData.tr(),
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
                          productModel: searchState.products[index],
                        ),
                      ),
                      SizedBox(
                        height: 13.5.h,
                      ),
                    ],
                  );
                },
                childCount: searchState.products.length,
              ),
            );
    }
    return const SliverToBoxAdapter();
  }
}
