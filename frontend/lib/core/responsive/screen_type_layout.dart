import 'package:flutter/material.dart';
import 'package:ibn_sina/core/responsive/context_extension.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';

class ScreenTypeLayout extends StatelessWidget {
  const ScreenTypeLayout({
    required this.medium,
    this.small,
    this.large,
    super.key,
  });

  final Widget medium;
  final Widget? small;
  final Widget? large;

  @override
  Widget build(BuildContext context) {
    final deviceScreenType = context.deviceScreenType;

    if (deviceScreenType.isLarge() && large != null) {
      return large!;
    } else if (deviceScreenType.isSmall() && small != null) {
      return small!;
    }
    return medium;
  }
}
