import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';

class RowItem1 extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String content;
  final bool enableContentLtr;
  final Color? titleColor;
  final Color? contentColor;

  const RowItem1({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    this.enableContentLtr = false,
    this.titleColor,
    this.contentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: subtitle == null ? 1 : 0,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: titleColor ?? AppColors.c2D2F3A,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        if (subtitle != null)
          Expanded(
            flex: 2,
            child: Text(
              ' ($subtitle)',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.c848484,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        SizedBox(
          width: 8.w,
        ),
        enableContentLtr
            ? Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: contentColor ?? Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : Text(
                content,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: contentColor ?? Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
      ],
    );
  }
}
