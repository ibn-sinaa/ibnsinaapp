import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../../cubit/forgot_password/forgot_password_cubit.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/success_widget.dart';
import 'phone_field.dart';
import 'reset_password_form.dart';

class ForgotPasswordBottomSheet extends StatelessWidget {
  const ForgotPasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HelperFunctions.unFocusKeyboard(),
      child: Container(
        height: double.infinity,
        color: Colors.transparent,
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().statusBarHeight + AppSizes.verticalPadding.h,
            ),
            Row(
              children: [
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    return state.forgotPasswordStep ==
                            ForgotPasswordStep.success
                        ? const SizedBox.shrink()
                        : const CustomBackButton();
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                listener: _handleListener,
                buildWhen: (previous, current) =>
                    previous.forgotPasswordStep != current.forgotPasswordStep,
                builder: (context, state) {
                  if (state.forgotPasswordStep == ForgotPasswordStep.phone) {
                    return const PhoneField();
                  }
                  //  else if (state.forgotPasswordStep ==
                  //     ForgotPasswordStep.otp) {
                  //   return OtpField(
                  //     sendAction: (otp) {
                  //       HelperFunctions.unFocusKeyboard(context);
                  //       final errorMessage = ValidatorHelper.validateOtp(otp);
                  //       if (errorMessage == null) {
                  //         context.read<ForgotPasswordCubit>().checkOtp(otp);
                  //       } else {
                  //         HelperFunctions.showToastMessage(
                  //             context, errorMessage);
                  //       }
                  //     },
                  //     resendAction: () {
                  //       return context.read<ForgotPasswordCubit>().resendOtp();
                  //     },
                  //     phone: state.phone,
                  //   );
                  // }
                  else if (state.forgotPasswordStep ==
                      ForgotPasswordStep.reset) {
                    return const ResetPasswordForm();
                  } else {
                    return SuccessWidget(
                      action: () {
                        AppRouter.pop(context);
                      },
                      title: AppStrings.passwordUpdatedSuccessfully.tr(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleListener(BuildContext context, ForgotPasswordState state) {
    HelperFunctions.submitActions(
      context,
      requestState: state.requestState,
      onLoaded: () {
        AppRouter.pop(context);
        if (state.forgotPasswordStep == ForgotPasswordStep.reset) {
          HelperFunctions.showToastMessage(context, state.message);
        }
      },
      onError: () {
        AppRouter.pop(context);
        HelperFunctions.showToastMessage(context, state.message);
      },
    );
  }
}
