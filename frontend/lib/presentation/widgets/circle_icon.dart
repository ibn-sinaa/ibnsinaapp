import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleIcon extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final double size;
  final double radius;
  final Color? color;

  const CircleIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 14,
    this.radius = 12,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: CircleAvatar(
        backgroundColor: color?.withOpacity(0.08) ??
            Theme.of(context).colorScheme.secondary.withOpacity(0.08),
        radius: radius.r,
        child: Icon(
          icon,
          size: size.w,
          color: color ?? Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
