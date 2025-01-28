import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SquareIcon extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final double size;
  final double radius;
  final Color? color;

  const SquareIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 22,
    this.radius = 2,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: (size + 12).w,
      icon: Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: color?.withOpacity(0.08) ??
              Theme.of(context).colorScheme.secondary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(radius.r),
        ),
        child: Icon(
          icon,
          size: size.w,
          color: color ?? Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
