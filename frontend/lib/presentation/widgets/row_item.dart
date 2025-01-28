import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/themes/app_colors.dart';

class RowItem extends StatelessWidget {
  final String title;
  final String content;
  final Widget? customContent;
  final double fontSize;
  final int? maxLines;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  final int flex;

  const RowItem({
    super.key,
    required this.title,
    this.content = '',
    this.customContent,
    this.fontSize = 13,
    this.maxLines,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          '$title : ',
          style: TextStyle(
            fontSize: fontSize.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.c989898,
          ),
        ),
        customContent ??
            Expanded(
              flex: flex,
              child: Text(
                content,
                style: TextStyle(
                  fontSize: (fontSize - 1).sp,
                  color: AppColors.c2D2F3A,
                  height: 1.5,
                ),
                maxLines: maxLines,
                overflow: maxLines == 1 ? TextOverflow.ellipsis : null,
                textAlign: TextAlign.start,
              ),
            ),
      ],
    );
  }
}
