import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../cubit/category/category_cubit.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../cubit/products/products_cubit.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/error_widget.dart';

class SubCategoryTaps extends StatefulWidget {
  final Function(int id) onTap;
  final String name;
  final int id;

  const SubCategoryTaps({
    super.key,
    required this.onTap,
    required this.name,
    required this.id,
  });

  @override
  State<SubCategoryTaps> createState() => _SubCategoryTapsState();
}

class _SubCategoryTapsState extends State<SubCategoryTaps> {
  int _selectedSubcategoryId = 0;

  @override
  void initState() {
    _selectedSubcategoryId = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding.w,
          ),
          child: Text(
            widget.name,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        SizedBox(
          height: 45.h,
          child: BlocConsumer<CategoryCubit, CategoryState>(
            listener: (context, state) {
              if (state is CategoryLoaded && state.categories.isNotEmpty) {
                setState(() {
                  _selectedSubcategoryId = state.categories.first.id;
                  context
                      .read<ProductsCubit>()
                      .getSubCategoryProducts(_selectedSubcategoryId);
                });
              }
            },
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const FetchLoading(
                  size: 40,
                );
              } else if (state is CategoryError) {
                return InlineErrorData(
                  onTap: () {
                    context.read<CategoryCubit>().getCategories();
                  },
                  size: 40,
                );
              } else if (state is CategoryLoaded) {
                return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding.w,
                  ),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return GestureDetector(
                      onTap: () {
                        HelperFunctions.unFocusKeyboard();
                        if (_selectedSubcategoryId != category.id) {
                          setState(() {
                            _selectedSubcategoryId = category.id;
                            widget.onTap(_selectedSubcategoryId);
                          });
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: EdgeInsets.symmetric(horizontal: 33.w),
                        decoration: BoxDecoration(
                          color: category.id == _selectedSubcategoryId
                              ? Theme.of(context).primaryColor
                              : AppColors.cF5F5F5,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: category.id == _selectedSubcategoryId
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
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
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
