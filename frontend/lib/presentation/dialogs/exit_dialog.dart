import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/routes/app_router.dart';
import '../../config/themes/app_colors.dart';
import '../../core/utils/app_strings.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        AppStrings.doYouWantToCloseTheApp.tr(),
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.c2D2F3A,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            AppRouter.pop(context, false);
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor,
          ),
          child: Text(
            AppStrings.no.tr(),
          ),
        ),
        TextButton(
          onPressed: () {
            AppRouter.pop(context, true);
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor,
          ),
          child: Text(
            AppStrings.yes.tr(),
          ),
        ),
      ],
    );
  }
}
