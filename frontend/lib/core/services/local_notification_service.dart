import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../config/routes/app_router.dart';
import '../../config/routes/app_routes.dart';
import '../../presentation/my_app.dart';
import '../helpers/helper_functions.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  LocalNotificationService();

  static Future<void> initialize() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        log('onDidReceiveNotificationResponse');
        if (details.payload == 'notification') {
          AppRouter.pushNamed(
              navigatorKey.currentState!.context, AppRoutes.notifications);
        }
      },
    );
  }

  static Future<void> display({
    required String title,
    required String body,
  }) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'ibn_sina',
          'ibn sina',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      );

      await _localNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: 'notification',
      );
    } catch (error) {
      log(error.toString());
    }
  }
}
