import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static Color c01628F = hexToColor('#01628F');
  static Color cF6F8FA = hexToColor('#F6F8FA');
  static Color cFAFCFF = hexToColor('#FAFCFF');
  static Color cFAFAFA = hexToColor('#FAFAFA');
  static Color cCCCCCC = hexToColor('#CCCCCC');
  static Color cF8F8F8 = hexToColor('#F8F8F8');
  static Color c37474F = hexToColor('#37474F');
  static Color c0CA000 = hexToColor('#0CA000');
  static Color c919191 = hexToColor('#919191');
  static Color cE27E1C = hexToColor('#E27E1C');
  static Color cAEB3BD = hexToColor('#AEB3BD');
  static Color cF5F7F9 = hexToColor('#F5F7F9');
  static Color cFFFFFF = hexToColor('#FFFFFF');
  static Color c2D2F3A = hexToColor('#2D2F3A');
  static Color c848484 = hexToColor('#848484');
  static Color c262626 = hexToColor('#262626');
  static Color c989898 = hexToColor('#989898');
  static Color cF5F5F5 = hexToColor('#F5F5F5');
  static Color cE2DFDF = hexToColor('#E2DFDF');
  static Color cF8FAFD = hexToColor('#F8FAFD');
  static Color c707070 = hexToColor('#707070');
  static Color cEF5350 = hexToColor('#EF5350');
  static Color cA3A9AD = hexToColor('#A3A9AD');
  static Color cF1F5FB = hexToColor('#F1F5FB');

  static Color hexToColor(String hexColor) {
    hexColor = hexColor.replaceFirst('#', hexColor.length == 7 ? 'FF' : '');
    return Color(int.parse(hexColor, radix: 16));
  }

  static ColorFilter colorFilter(Color color) =>
      ColorFilter.mode(color, BlendMode.srcIn);
}
