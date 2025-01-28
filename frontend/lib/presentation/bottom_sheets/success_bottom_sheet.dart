import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/utils/app_images.dart';
import '../widgets/success_widget.dart';

class SuccessBottomSheet extends StatelessWidget {
  final Function() action;
  final String title;
  final double? size;

  const SuccessBottomSheet({
    super.key,
    required this.action,
    required this.title,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            SvgImages.line,
            width: 54.w,
            height: 5.h,
          ),
          SizedBox(
            height: 47.h,
          ),
          SuccessWidget(
            action: action,
            title: title,
          ),
        ],
      ),
    );
  }
}
