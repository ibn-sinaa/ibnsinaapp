import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_images.dart';

class SuccessWidget extends StatefulWidget {
  final Function() action;
  final String title;
  final double? size;

  const SuccessWidget({
    super.key,
    required this.action,
    required this.title,
    this.size,
  });

  @override
  State<SuccessWidget> createState() => _SuccessWidgetState();
}

class _SuccessWidgetState extends State<SuccessWidget> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      widget.action();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 1),
        tween: Tween<double>(begin: 0, end: 1),
        curve: Curves.easeIn,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.success,
                  width: widget.size?.w ?? 200.w,
                  height: widget.size?.w ?? 200.w,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
