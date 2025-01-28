import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/routes/app_router.dart';
import '../../config/routes/app_routes.dart';
import '../../cubit/notifications_count/notifications_count_cubit.dart';
import '../../presentation/my_app.dart';
import '../helpers/helper_functions.dart';
import '../utils/app_constants.dart';
import 'local_notification_service.dart';

class NotificationService {
  NotificationService._();

  static final _firebaseMessaging = FirebaseMessaging.instance;

  // myApp => init state
  static Future<void> initialize() async {
    LocalNotificationService.initialize();
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // gives you the message on which user taps
    // and it opened the app from terminated state
    _firebaseMessaging.getInitialMessage().then((message) async {
      log('getInitialMessage');
      if (message != null) {
        _incrementNotificationsCountInBackground();
        Future.delayed(const Duration(milliseconds: 3100), () {
          _goToNotificationScreen();
        });
      }
    });
  }

  static Future<void> subscribeToTopic() async {
    await _firebaseMessaging.subscribeToTopic('all');
  }

  static Future<void> unsubscribeFromTopic() async {
    await _firebaseMessaging.unsubscribeFromTopic('all');
  }

  // when the app in forground -> myApp => init state
  static void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('onMessage');
      if (message.notification != null) {
        _incrementNotificationsCountInForground();
        LocalNotificationService.display(
          title: message.notification!.title!,
          body: message.notification!.body!,
        );
      }
    });
  }

  // when the app in background but opened and user taps -> myApp => init state
  static void onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      log('onMessageOpenedApp');
      _goToNotificationScreen();
    });
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    log('onBackgroundMessage');
    log(message.notification?.title);
    _incrementNotificationsCountInBackground();
  }

  // when the app in background but opened -> main => before runApp
  static void onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  static void _goToNotificationScreen() {
    AppRouter.pushNamed(navigatorKey.currentContext!, AppRoutes.notifications);
  }

  static void _incrementNotificationsCountInForground() {
    navigatorKey.currentContext
        ?.read<NotificationsCountCubit>()
        .incrementNotificationsCount();
  }

  static void _incrementNotificationsCountInBackground() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final count = prefs.getInt(AppConstants.notificationsCount) ?? 0;
    await prefs.setInt(AppConstants.notificationsCount, count + 1);
  }
}
