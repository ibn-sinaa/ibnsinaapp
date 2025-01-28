import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../cubit/category/category_cubit.dart';
import '../../../cubit/products/products_cubit.dart';
import '../../../cubit/search/search_cubit.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/search_result_widget.dart';
import '../../widgets/search_text_field.dart';
import 'widgets/category_products.dart';
import 'widgets/sub_category_taps.dart';

class CategoryScreen extends StatefulWidget {
  final String name;
  final int categoryId;

  const CategoryScreen({
    super.key,
    required this.name,
    required this.categoryId,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _scrollController = ScrollController();
  bool _showFab = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HelperFunctions.unFocusKeyboard(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.name,
          leading: const CustomBackButton(),
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, searchState) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (!searchState.showSearchResult) {
                  if (notification.metrics.pixels < 200 && _showFab == true) {
                    setState(() {
                      _showFab = false;
                    });
                  } else if (notification.metrics.pixels > 200 &&
                      _showFab == false) {
                    setState(() {
                      _showFab = true;
                    });
                  }
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent) {
                    context.read<ProductsCubit>().loadMoreProducts();
                  }
                }
                return !searchState.showSearchResult;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<CategoryCubit>().getCategories();
                  context.read<ProductsCubit>().resetState();
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: AppSizes.verticalPadding.h,
                              left: AppSizes.horizontalPadding.w,
                              right: AppSizes.horizontalPadding.w,
                            ),
                            child: SearchTextField(
                              onChanged: (value) {
                                context
                                    .read<SearchCubit>()
                                    .searchForProduct(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          if (!searchState.showSearchResult) ...[
                            SubCategoryTaps(
                              onTap: (id) {
                                context
                                    .read<ProductsCubit>()
                                    .getSubCategoryProducts(id);
                              },
                              name: widget.name,
                              id: context
                                  .read<ProductsCubit>()
                                  .currentSubcategoryId,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                          ],
                        ],
                      ),
                    ),
                    searchState.showSearchResult
                        ? SearchResultWidget(
                            searchState: searchState,
                          )
                        : const CategoryProducts(),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: Builder(builder: (context) {
          const duration = Duration(milliseconds: 300);
          return AnimatedSlide(
            duration: duration,
            offset: _showFab ? Offset.zero : const Offset(0, 2),
            child: AnimatedOpacity(
              duration: duration,
              opacity: _showFab ? 1 : 0,
              child: SizedBox(
                height: 50.w,
                width: 50.w,
                child: FloatingActionButton(
                  onPressed: () {
                    _scrollController.animateTo(
                      0,
                      duration: duration,
                      curve: Curves.easeIn,
                    );
                    setState(() {
                      _showFab = false;
                    });
                  },
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 30.w,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
