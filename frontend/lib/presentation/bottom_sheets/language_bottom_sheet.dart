import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';

import '../../config/locale/language_manager.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_strings.dart';
import '../widgets/custom_radio_tile.dart';

class LanguageBottomSheet extends StatefulWidget {
  final Function(Locale locale) updateLanguage;

  const LanguageBottomSheet({
    super.key,
    required this.updateLanguage,
  });

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late Locale _currentLocale;

  @override
  void didChangeDependencies() {
    _currentLocale = LanguageManager.getCurrentLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 32.w,
        right: 32.w,
        top: 33.h,
        bottom: 47.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            SvgImages.line,
            width: 54.w,
            height: 5.h,
          ),
          SizedBox(
            height: 47.h,
          ),
          Text(
            AppStrings.changeLanguage.tr(),
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 57.h,
          ),
          CustomRadioTile<Locale>(
            onChanged: (locale) {
              if (_currentLocale != LanguageManager.enLocale) {
                setState(() {
                  _currentLocale = LanguageManager.enLocale;
                });
              }
            },
            value: LanguageManager.enLocale,
            groupValue: _currentLocale,
            title: AppStrings.english,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomRadioTile<Locale>(
            onChanged: (locale) {
              if (_currentLocale != LanguageManager.arLocale) {
                setState(() {
                  _currentLocale = LanguageManager.arLocale;
                });
              }
            },
            value: LanguageManager.arLocale,
            groupValue: _currentLocale,
            title: AppStrings.arabic,
          ),
          SizedBox(
            height: 63.h,
          ),
          CustomButton(
            onPressed: () {
              widget.updateLanguage(_currentLocale);
            },
            text: AppStrings.confirm.tr().toUpperCase(),
            width: double.maxFinite,
          ),
        ],
      ),
    );
  }
}
