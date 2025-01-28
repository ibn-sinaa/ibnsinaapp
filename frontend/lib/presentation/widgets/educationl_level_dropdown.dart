import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/presentation/widgets/custom_text_field.dart';
import 'package:ibn_sina/presentation/widgets/drop_down/custom_drop_down.dart';

class EducationalLevelDropdown extends StatefulWidget {
  const EducationalLevelDropdown({
    super.key,
    required this.selectedLevel,
    required this.onEducationalLevelChanged,
    required this.onUniversityNameChanged,
    required this.universityNameVidator,
    this.universityName,
  });

  final EducationalLevel? selectedLevel;
  final void Function(EducationalLevel?)? onEducationalLevelChanged;
  final void Function(String)? onUniversityNameChanged;
  final String? Function(String?)? universityNameVidator;
  final String? universityName;

  @override
  State<EducationalLevelDropdown> createState() =>
      _EducationalLevelDropdownState();
}

class _EducationalLevelDropdownState extends State<EducationalLevelDropdown> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.universityName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropDown<EducationalLevel>(
          items: EducationalLevel.values,
          value: widget.selectedLevel,
          enableUnderLine: false,
          enableOutlineBorder: true,
          hintText: AppStrings.educationalLevel.tr(),
          lableSize: 10,
          builder: (level) {
            return Row(
              children: [
                SizedBox(
                  width: getValueForScreenType(context, small: 8, medium: 4).w,
                ),
                SvgPicture.asset(
                  SvgImages.student,
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
                  level.value.tr(),
                  style: TextStyle(
                    fontSize:
                        getValueForScreenType(context, small: 16, medium: 14)
                            .sp,
                    color: AppColors.c2D2F3A,
                    height: 2,
                  ),
                ),
              ],
            );
          },
          onChanged: widget.onEducationalLevelChanged,
        ),
        if (widget.selectedLevel == EducationalLevel.university) ...[
          SizedBox(
            height: getValueForScreenType(context, medium: 20, large: 28).h,
          ),
          CustomTextField(
            controller: _controller,
            labelText: AppStrings.universityName.tr(),
            onChanged: widget.onUniversityNameChanged,
            validator: widget.universityNameVidator,
            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(
                start: getValueForScreenType(context,
                        small: 3, medium: 0, large: 3)
                    .w,
              ),
              child: SvgPicture.asset(
                SvgImages.student,
                colorFilter: AppColors.colorFilter(
                    Theme.of(context).colorScheme.secondary),
                width: getValueForScreenType(
                  context,
                  small: 24,
                  medium: 20,
                  large: 24,
                ).r,
              ),
            ),
          )
        ]
      ],
    );
  }
}
