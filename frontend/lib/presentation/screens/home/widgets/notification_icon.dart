import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationIcon extends StatelessWidget {
  final int count;

  const NotificationIcon({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.w,
      width: 16.w,
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Center(
        child: FittedBox(
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
