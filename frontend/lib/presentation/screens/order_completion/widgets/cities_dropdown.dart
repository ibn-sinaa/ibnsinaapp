import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/cubit/city/city_cubit.dart';
import 'package:ibn_sina/data/models/city_model.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';
import 'package:ibn_sina/presentation/widgets/drop_down/custom_drop_down.dart';
import '../../../../../core/utils/app_strings.dart';

import '../../../../../config/themes/app_colors.dart';

class CitiesDropdown extends StatelessWidget {
  final CityModel? selectedCity;
  final void Function(CityModel? city)? onChanged;

  const CitiesDropdown({
    super.key,
    required this.selectedCity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<CityCubit, CityState>(
          builder: (context, state) {
            return CustomDropDown<CityModel>(
              items: state is CityLoaded ? state.cities : [],
              value: selectedCity,
              enableUnderLine: false,
              enableOutlineBorder: true,
              hintText: AppStrings.selectCity.tr(),
              icon: state is CityLoading
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: const InlineLoading(
                        size: 20,
                      ),
                    )
                  : state is CityError
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: GestureDetector(
                            onTap: context.read<CityCubit>().getCities(),
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
              builder: (city) {
                return Text(
                  city.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.c2D2F3A,
                    fontWeight: FontWeight.w500,
                  ),
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
