import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/presentation/widgets/row_item.dart';

class PrintingSizeText extends StatelessWidget {
  const PrintingSizeText({
    super.key,
    required this.height,
    required this.width,
  });

  final int height;
  final int width;

  @override
  Widget build(BuildContext context) {
    return RowItem(
      title: AppStrings.printingSize.tr(),
      customContent: Row(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              HelperFunctions.handlePrintingSize(context, height, width),
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.c2D2F3A,
                height: 1.5,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
