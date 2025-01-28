import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/services/notification_service.dart';

import '../config/routes/routes_generator_imports.dart';
import '../config/themes/app_themes.dart';
import '../core/utils/app_strings.dart';
import '../global_providers.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationService.initialize();
    NotificationService.onMessage();
    NotificationService.onMessageOpenedApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiBlocProvider(
      providers: globalProviders,
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) => MaterialApp(
          navigatorKey: navigatorKey,
          title: AppStrings.appTitle,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          // builder: DevicePreview.appBuilder,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          theme: appThemes,
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}
