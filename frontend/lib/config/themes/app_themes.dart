import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_sizes.dart';
import 'app_colors.dart';

ThemeData appThemes = ThemeData(
  fontFamily: AppConstants.fontFamily,
  primaryColor: AppColors.c01628F,
  canvasColor: AppColors.cFFFFFF,
  shadowColor: AppColors.cE2DFDF,
  unselectedWidgetColor: AppColors.cAEB3BD,
  colorScheme: ColorScheme.light(
    primary: AppColors.c01628F,
    secondary: AppColors.cE27E1C,
    background: AppColors.cFFFFFF,
    error: AppColors.cEF5350,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    surfaceTintColor: Colors.transparent,
    backgroundColor: AppColors.cF5F7F9,
    elevation: 0,
    shadowColor: Colors.transparent,
    centerTitle: true,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: _textFieldBorder(AppColors.c707070),
    disabledBorder: _textFieldBorder(AppColors.c707070),
    focusedBorder: _textFieldBorder(AppColors.c01628F),
    errorBorder: _textFieldBorder(AppColors.cEF5350),
    focusedErrorBorder: _textFieldBorder(AppColors.cEF5350),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.c01628F,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius.r),
      ),
      shadowColor: AppColors.cE2DFDF,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        fontFamily: AppConstants.fontFamily,
        height: 1.3,
      ),
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 24.w),
      side: BorderSide(
        color: AppColors.cE27E1C,
        width: AppSizes.borderWidth.r,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius.r),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textStyle: TextStyle(
        color: AppColors.cE27E1C,
        fontSize: 14.sp,
        fontFamily: AppConstants.fontFamily,
      ),
      foregroundColor: AppColors.cE27E1C,
    ),
  ),
  iconTheme: IconThemeData(size: 24.w),
  listTileTheme: const ListTileThemeData(
    dense: true,
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9.r),
    ),
    shadowColor: AppColors.cE2DFDF,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    iconSize: 12.w,
  ),
  dividerTheme: DividerThemeData(
    color: AppColors.c707070.withOpacity(0.1),
    thickness: 1.h,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
  ),
  dialogTheme: DialogTheme(
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radius.r),
    ),
  ),
);

InputBorder _textFieldBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      AppSizes.radius.r,
    ),
    borderSide: BorderSide(
      color: color,
      width: AppSizes.borderWidth.r,
    ),
  );
}
