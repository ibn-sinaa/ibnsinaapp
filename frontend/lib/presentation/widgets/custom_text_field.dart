import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';

import '../../config/themes/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final String? hintText;
  final String? labelText;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final bool? obscureText;
  final Widget? prefixIcon;
  final double? prefixIconPadding;
  final Widget? suffixIcon;
  final bool enableSuffixPadding;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final int maxLines;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final int maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.nextNode,
    this.hintText,
    this.labelText,
    this.border,
    this.enabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.keyboardType,
    this.textInputAction,
    this.enabled,
    this.obscureText,
    this.prefixIcon,
    this.prefixIconPadding,
    this.suffixIcon,
    this.enableSuffixPadding = true,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.maxLength = 0,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).colorScheme.secondary,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      maxLines: maxLines,
      obscureText: obscureText ?? false,
      obscuringCharacter: '✶',
      textAlign: textAlign,
      inputFormatters: inputFormatters ??
          [
            if (maxLength > 0) LengthLimitingTextInputFormatter(maxLength),
          ],
      style: style ??
          TextStyle(
            fontSize: getValueForScreenType(context, small: 16, medium: 14).sp,
            color: AppColors.c2D2F3A,
            height: 2,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              fontSize: 14.sp,
              color: AppColors.c262626,
            ),
        labelText: labelText,
        labelStyle: labelStyle ??
            TextStyle(
              fontSize:
                  getValueForScreenType(context, small: 16, medium: 14).sp,
              color: AppColors.c848484,
            ),
        floatingLabelStyle: TextStyle(
          fontSize: getValueForScreenType(
            context,
            small: 16,
            medium: 14,
            large: 16,
          ).sp,
          color: AppColors.c848484,
        ),
        errorStyle: TextStyle(
          fontSize: getValueForScreenType(
            context,
            small: 12,
            medium: 10,
            large: 12,
          ).sp,
          color: Theme.of(context).colorScheme.error,
        ),
        alignLabelWithHint: true,
        border: border,
        enabledBorder: enabledBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: focusedErrorBorder,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: getValueForScreenType(
                context,
                medium: 14,
                large: 17,
              ).h,
            ),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsetsDirectional.only(
                  start:
                      getValueForScreenType(context, medium: 18, large: 14).w,
                  end: getValueForScreenType(context, medium: 0, large: 14).w,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    prefixIcon!,
                  ],
                ),
              )
            : null,
        suffixIcon: enableSuffixPadding
            ? suffixIcon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      suffixIcon!,
                      SizedBox(
                        width: 6.w,
                      ),
                    ],
                  )
                : null
            : suffixIcon,
      ),
      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(nextNode),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
