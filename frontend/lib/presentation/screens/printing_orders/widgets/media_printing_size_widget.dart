import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/presentation/widgets/custom_text_field.dart';

class MediaPrintingSizeWidget extends StatefulWidget {
  const MediaPrintingSizeWidget({
    super.key,
    required this.onHeightChanded,
    required this.onWidthChanded,
    required this.height,
    required this.width,
  });

  final void Function(int height) onHeightChanded;
  final void Function(int width) onWidthChanded;
  final int height;
  final int width;

  @override
  State<MediaPrintingSizeWidget> createState() =>
      _MediaPrintingSizeWidgetState();
}

class _MediaPrintingSizeWidgetState extends State<MediaPrintingSizeWidget> {
  final _heightController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightNode = FocusNode();
  final _widthNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _heightNode.addListener(_heightListener);
    _widthNode.addListener(_widthListener);
  }

  void _heightListener() {
    if (_heightNode.hasFocus) {
      _heightController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _heightController.text.length,
      );
    } else {
      final height = int.tryParse(_heightController.text);
      _heightController.text = '${height ?? ''}';
    }
  }

  void _widthListener() {
    if (_widthNode.hasFocus) {
      _widthController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _widthController.text.length,
      );
    } else {
      final width = int.tryParse(_widthController.text);
      _widthController.text = '${width ?? ''}';
    }
  }

  @override
  void didUpdateWidget(covariant MediaPrintingSizeWidget oldWidget) {
    _heightController.text = '${widget.height == 0 ? '' : widget.height}';
    _widthController.text = '${widget.width == 0 ? '' : widget.width}';
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _heightController.dispose();
    _widthController.dispose();
    _heightNode.removeListener(_heightListener);
    _widthNode.removeListener(_widthListener);
    _heightNode.dispose();
    _widthNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '● ${AppStrings.printingSize.tr()}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(
              width: 32.w,
            ),
            Row(
              children: [
                SizedBox(
                  width: 90.w,
                  child: CustomTextField(
                    controller: _heightController,
                    focusNode: _heightNode,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical:
                          getValueForScreenType(context, medium: 0, large: 6).h,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.c2D2F3A,
                      fontWeight: FontWeight.w500,
                      height: 2,
                    ),
                    hintText: AppStrings.height.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    // [
                    //   FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'))
                    // ],
                    onChanged: (value) {
                      final height = int.tryParse(value) ?? 0;
                      widget.onHeightChanded(height);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.w,
                    right: 12.w,
                    top: 8.h,
                  ),
                  child: Text(
                    'X',
                    style: TextStyle(
                      fontSize: 25.sp,
                      color: AppColors.c707070,
                    ),
                  ),
                ),
                SizedBox(
                  width: 90.w,
                  child: CustomTextField(
                    controller: _widthController,
                    focusNode: _widthNode,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical:
                          getValueForScreenType(context, medium: 0, large: 6).h,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.c2D2F3A,
                      fontWeight: FontWeight.w500,
                      height: 2,
                    ),
                    hintText: AppStrings.width.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    // [
                    //   FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'))
                    // ],
                    onChanged: (value) {
                      final width = int.tryParse(value) ?? 0;
                      widget.onWidthChanded(width);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          AppStrings.pleaseEnterHeightAndWidthMeasurementsInCentimeters.tr(),
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.cEF5350,
          ),
        )
      ],
    );
  }
}
