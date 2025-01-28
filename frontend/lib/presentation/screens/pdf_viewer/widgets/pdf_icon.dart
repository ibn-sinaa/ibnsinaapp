import 'package:flutter/material.dart';
import 'package:ibn_sina/presentation/widgets/custom_icon_button.dart';

class PdfIcon extends StatelessWidget {
  const PdfIcon({
    super.key,
    required this.onTap,
    required this.icon,
    this.angle,
    this.size,
  });

  final VoidCallback onTap;
  final String icon;
  final double? angle;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle ?? 0,
      child: CustomIconButton(
        onTap: onTap,
        icon: icon,
        size: size ?? 8,
        bottomPadding: 0,
        bgColor: Theme.of(context).colorScheme.secondary.withOpacity(0.04),
        iconColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
