import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/services/notification_service.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/cubit/delete_account/delete_account_cubit.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listener: _listener,
      child: AlertDialog(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius.r),
        ),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding.w,
          vertical: AppSizes.verticalPadding.h,
        ),
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                AppSizes.radius.r,
              ),
            ),
            color: AppColors.c01628F,
          ),
          child: Text(
            AppStrings.deleteAccount.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.doYouWantToDeleteTheAccount.tr(),
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.c37474F,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      AppRouter.pop(context);
                    },
                    text: AppStrings.no.tr(),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      context.read<DeleteAccountCubit>().deleteAccount();
                    },
                    text: AppStrings.yes.tr(),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor: AppColors.cEF5350,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _listener(BuildContext context, DeleteAccountState state) {
    if (state is DeleteAccountLoading) {
      HelperFunctions.showAppDialog(context, child: SubmitLoading());
    } else if (state is DeleteAccountError) {
      AppRouter.pop(context);
      HelperFunctions.showToastMessage(context, state.message);
    } else if (state is DeleteAccountLoaded) {
      AppRouter.pop(context);
      HelperFunctions.showToastMessage(context, state.message);
      AppRouter.pushNamedAndRemoveUntil(context, AppRoutes.signIn);
      NotificationService.unsubscribeFromTopic();
    }
  }
}
