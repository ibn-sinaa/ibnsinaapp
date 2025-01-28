import 'package:flutter/material.dart';

extension NumExtension on num {
  int cacheSize(BuildContext context) =>
      (this * MediaQuery.of(context).devicePixelRatio).round();
}
