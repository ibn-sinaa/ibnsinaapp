import 'package:flutter/material.dart';
import 'package:ibn_sina/core/responsive/context_extension.dart';

T getValueForScreenType<T>(
  BuildContext context, {
  required T medium,
  T? small,
  T? large,
}) {
  final deviceScreenType = context.deviceScreenType;
  if (deviceScreenType.isLarge() && large != null) {
    return large;
  } else if (deviceScreenType.isSmall() && small != null) {
    return small;
  }
  return medium;
}

enum DeviceScreenType { small, medium, large }

extension DeviceScreenTypeExtension on DeviceScreenType {
  bool isSmall() => this == DeviceScreenType.small;
  bool isMedium() => this == DeviceScreenType.medium;
  bool isLarge() => this == DeviceScreenType.large;
}
