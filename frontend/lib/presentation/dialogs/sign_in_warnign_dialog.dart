import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/services/notification_service.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/cubit/user/user_cubit.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';

class SignInWarningDialog extends StatelessWidget {
  const SignInWarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius.r),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding.w,
        vertical: AppSizes.verticalPadding.h,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.pleaseSignInAsAUserToContinue.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.c2D2F3A,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(
            onPressed: () {
              context.read<UserCubit>().unauthenticateUser();
              AppRouter.pushNamedAndRemoveUntil(context, AppRoutes.signIn);
            },
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 24.w,
            ),
            text: AppStrings.signIn.tr(),
          ),
        ],
      ),
    );
  }
}
