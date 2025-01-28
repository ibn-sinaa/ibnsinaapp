import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import 'package:url_launcher/link.dart';

class QuotationDetailsItem extends StatelessWidget {
  final String title;
  final String content;
  final bool isLink;

  const QuotationDetailsItem({
    super.key,
    required this.title,
    required this.content,
    this.isLink = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding.w,
            vertical: AppSizes.verticalPadding.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: AppColors.cF8FAFD,
          ),
          child: isLink
              ? Link(
                  uri: Uri.parse(content),
                  builder: (context, followLink) {
                    return InkWell(
                      onTap: followLink,
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                )
              : Text(
                  content,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.c848484,
                  ),
                ),
        )
      ],
    );
  }
}
