import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/cubit/branch/branch_cubit.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';
import 'package:ibn_sina/presentation/widgets/row_item.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../data/models/branch_model.dart';
import '../../../widgets/drop_down/custom_drop_down.dart';

import '../../../../config/themes/app_colors.dart';

class BranchesDropdown extends StatelessWidget {
  final BranchModel? selectedBranch;
  final void Function(BranchModel? branch)? onChanged;

  const BranchesDropdown({
    super.key,
    required this.selectedBranch,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.pleaseSelectTheBranchToBeReceivedFrom.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        BlocBuilder<BranchCubit, BranchState>(
          builder: (context, state) {
            return CustomDropDown<BranchModel>(
              items: state is BranchLoaded ? state.branches : [],
              value: selectedBranch,
              enableUnderLine: false,
              enableOutlineBorder: true,
              hintText: AppStrings.selectBranch.tr(),
              icon: state is BranchLoading
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: const InlineLoading(
                        size: 20,
                      ),
                    )
                  : state is BranchError
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: GestureDetector(
                            onTap: context.read<BranchCubit>().getBranches,
                            child: SvgPicture.asset(
                              SvgImages.refresh,
                              width: 20.w,
                              colorFilter: ColorFilter.mode(
                                AppColors.cEF5350,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        )
                      : null,
              builder: (branch) {
                return RowItem(
                  title: branch.city.name,
                  content: branch.name,
                  fontSize: 14,
                );
              },
              onChanged: onChanged,
            );
          },
        ),
      ],
    );
  }
}
