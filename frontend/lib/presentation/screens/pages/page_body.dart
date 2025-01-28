import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../cubit/page/page_cubit.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/error_widget.dart';

class PageBody extends StatelessWidget {
  final Function() onError;

  const PageBody({super.key, required this.onError});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, PageState>(
      builder: (context, state) {
        if (state is PageStateLoading) {
          return const FetchLoading();
        } else if (state is PageStateError) {
          return ErrorData(
            onTap: onError,
            message: state.message,
          );
        } else if (state is PageStateLoaded) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding.w,
              vertical: AppSizes.verticalPadding.h,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    state.pageModel.name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.c2D2F3A,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    state.pageModel.content,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.c2D2F3A,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
