import 'package:flutter/material.dart';

class AppRouter {
  const AppRouter._();

  static pop<T extends Object?>(BuildContext context, [T? result]) =>
      Navigator.pop(context, result);

  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  static pushReplacementNamed(BuildContext context, String routeName,
          {Object? arguments}) =>
      Navigator.pushReplacementNamed(context, routeName, arguments: arguments);

  static Future<T?> pushNamed<T extends Object?>(
          BuildContext context, String routeName,
          {Object? arguments}) =>
      Navigator.pushNamed(context, routeName, arguments: arguments);

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  static bool canPop(BuildContext context) => Navigator.canPop(context);
}
