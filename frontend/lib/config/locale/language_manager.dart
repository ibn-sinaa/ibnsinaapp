import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../config.dart';
import '../../core/services/service_locator.dart';

class LanguageManager {
  const LanguageManager._();

  static const String path = 'assets/translations';

  static const arLocale = Locale('ar', 'SA');
  static const enLocale = Locale('en', 'US');

  static const List<Locale> supportLocales = [arLocale, enLocale];

  static bool isEnglish(BuildContext context) {
    return context.locale.languageCode == 'en';
  }

  static String getCurrentLanguageCode(BuildContext context) {
    return context.locale.languageCode;
  }

  static Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  static toggleLanguage(BuildContext context) async {
    await context.setLocale(isEnglish(context) ? arLocale : enLocale);
  }

  static changeLanugage(BuildContext context, Locale locale) async {
    final config = locator<Config>();
    ServiceLocator.saveConfig(
      config.copyWith(languageCode: locale.languageCode),
    );
    await context.setLocale(locale);
  }
}
