import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../cubit/branch/branch_cubit.dart';
import 'widgets/branch_item_widget.dart';
import '../../widgets/custom_back_button.dart';

import '../../widgets/custom_loading.dart';
import '../../widgets/error_widget.dart';

class OurBranchesScreen extends StatelessWidget {
  const OurBranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.ourBranches.tr(),
        leading: const CustomBackButton(),
      ),
      body: BlocBuilder<BranchCubit, BranchState>(
        builder: (context, state) {
          if (state is BranchLoading) {
            return const FetchLoading();
          } else if (state is BranchError) {
            return ErrorData(
              onTap: () {
                context.read<BranchCubit>().getBranches();
              },
              message: state.message,
            );
          } else if (state is BranchLoaded) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding.w,
                vertical: AppSizes.verticalPadding.h,
              ),
              itemBuilder: (context, index) {
                return BranchItemWidget(
                  branchModel: state.branches[index],
                );
              },
              separatorBuilder: (_, __) {
                return SizedBox(
                  height: 18.h,
                );
              },
              itemCount: state.branches.length,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
