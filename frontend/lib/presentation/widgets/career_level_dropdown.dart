import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/cubit/career_level/career_level_cubit.dart';
import 'package:ibn_sina/data/models/career_model.dart';
import 'package:ibn_sina/data/repositories/app_repository.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';
import 'package:ibn_sina/presentation/widgets/drop_down/custom_drop_down.dart';
import '../../../../../core/utils/app_strings.dart';

import '../../../../../config/themes/app_colors.dart';

class CareerLevelsDropdown extends StatelessWidget {
  final CareerModel? selectedCareerLevel;
  final void Function(CareerModel? careerLevel)? onChanged;
  final String? apiToken;

  const CareerLevelsDropdown({
    super.key,
    required this.selectedCareerLevel,
    required this.onChanged,
    this.apiToken,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CareerLevelCubit>(
      create: (context) =>
          CareerLevelCubit(locator<AppRepository>())..getCareerLevels(apiToken),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<CareerLevelCubit, CareerLevelState>(
            builder: (context, state) {
              return CustomDropDown<CareerModel>(
                items: state is CareerLevelLoaded ? state.careerLevels : [],
                value: selectedCareerLevel,
                enableUnderLine: false,
                enableOutlineBorder: true,
                hintText: AppStrings.careerLevel.tr(),
                icon: state is CareerLevelLoading
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: const InlineLoading(
                          size: 20,
                        ),
                      )
                    : state is CareerLevelError
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: GestureDetector(
                              onTap: context
                                  .read<CareerLevelCubit>()
                                  .getCareerLevels(),
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
                builder: (careerLevel) {
                  return Row(
                    children: [
                      SizedBox(
                        width:
                            getValueForScreenType(context, small: 8, medium: 4)
                                .w,
                      ),
                      SvgPicture.asset(
                        SvgImages.career,
                        width: getValueForScreenType(
                          context,
                          small: 24,
                          medium: 20,
                          large: 26,
                        ).r,
                        colorFilter: AppColors.colorFilter(
                            Theme.of(context).colorScheme.secondary),
                      ),
                      SizedBox(
                        width: getValueForScreenType(
                          context,
                          small: 17,
                          medium: 15,
                          large: 19,
                        ).w,
                      ),
                      Text(
                        careerLevel.name,
                        style: TextStyle(
                          fontSize: getValueForScreenType(
                            context,
                            small: 16,
                            medium: 14,
                          ).sp,
                          color: AppColors.c2D2F3A,
                          height: 2,
                        ),
                      ),
                    ],
                  );
                },
                onChanged: onChanged,
              );
            },
          ),
        ],
      ),
    );
  }
}
