import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibn_sina/core/helpers/pdf_helper.dart';
import 'package:ibn_sina/data/models/option_model/option_model.dart';
import 'package:ibn_sina/firebase_options.dart';
import 'config/locale/language_manager.dart';
import 'core/services/notification_service.dart';
import 'core/services/service_locator.dart';
import 'data/models/amount/amount_model.dart';
import 'data/models/cart/cart_model.dart';
import 'data/models/category/category_model.dart';
import 'data/models/option_data/option_data_model.dart';
import 'data/models/product/product_model.dart';
import 'presentation/my_app.dart';

void main() async {
  await _initConfig();

  runApp(
    EasyLocalization(
      path: LanguageManager.path,
      supportedLocales: LanguageManager.supportLocales,
      startLocale: LanguageManager.arLocale,
      child: const MyApp(),
    ),
  );
}

Future _initConfig() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ServiceLocator.init();
  await GetStorage.init();
  await PdfHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.onBackgroundMessage();

  await Hive.initFlutter();

  Hive.registerAdapter(AmountModelAdapter());
  Hive.registerAdapter(OptionDataModelAdapter());
  Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(OptionModelAdapter());
  Hive.registerAdapter(DefaultOptionModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
}
