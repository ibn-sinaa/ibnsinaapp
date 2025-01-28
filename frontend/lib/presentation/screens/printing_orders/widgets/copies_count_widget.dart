import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/cubit/hide_bottom_sheet/hide_bottom_sheet_cubit.dart';
import 'package:ibn_sina/presentation/widgets/custom_icon_button.dart';
import 'package:ibn_sina/presentation/widgets/custom_text_field.dart';

class CopiesCountWidget extends StatefulWidget {
  const CopiesCountWidget({
    super.key,
    required this.onChanged,
    required this.initialCount,
  });

  final void Function(int count) onChanged;
  final int initialCount;

  @override
  State<CopiesCountWidget> createState() => _CopiesCountWidgetState();
}

class _CopiesCountWidgetState extends State<CopiesCountWidget> {
  final _counterController = TextEditingController(text: '1');
  final _counterFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _counterFocus.addListener(_focusListener);
  }

  void _focusListener() {
    if (_counterFocus.hasFocus) {
      _counterController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _counterController.text.length,
      );
      context.read<HideBottomSheetCubit>().hide();
    } else {
      final number = int.tryParse(_counterController.text) ?? 0;
      if (number == 0) {
        _counterController.text = '1';
      }
    }
  }

  @override
  void didUpdateWidget(covariant CopiesCountWidget oldWidget) {
    if (widget.initialCount == 1) {
      _counterController.text = '1';
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _counterController.dispose();
    _counterFocus.removeListener(_focusListener);
    _counterFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            '● ${AppStrings.copiesCount.tr()}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        SizedBox(
          width: 32.w,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomIconButton(
              onTap: () {
                final number = int.tryParse(_counterController.text) ?? 0;
                _counterController.text = '${number + 1}';
                widget.onChanged(number + 1);
              },
              icon: SvgImages.plus,
              iconColor: Theme.of(context).colorScheme.secondary,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 12.w,
                right: 12.w,
                top: 2.h,
              ),
              child: SizedBox(
                width: 90.w,
                child: CustomTextField(
                  controller: _counterController,
                  focusNode: _counterFocus,
                  hintText: '1',
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.c2D2F3A,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical:
                        getValueForScreenType(context, medium: 0, large: 6).h,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    final number = int.tryParse(value) ?? 0;
                    if (number > 0) {
                      widget.onChanged(number);
                    }
                  },
                ),
              ),
            ),
            CustomIconButton(
              onTap: () {
                final number = int.tryParse(_counterController.text) ?? 0;
                if (number > 1) {
                  _counterController.text = '${number - 1}';
                  widget.onChanged(number - 1);
                }
              },
              icon: SvgImages.minus,
              iconColor: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ],
    );
  }
}
