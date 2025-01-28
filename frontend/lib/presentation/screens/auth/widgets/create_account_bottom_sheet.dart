import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../../cubit/create_account/create_account_cubit.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/success_widget.dart';
import 'create_account.dart';
import 'otp_field.dart';

class CreateAccountBottomSheet extends StatefulWidget {
  final String phone;

  const CreateAccountBottomSheet({super.key, required this.phone});

  @override
  State<CreateAccountBottomSheet> createState() =>
      _CreateAccountBottomSheetState();
}

class _CreateAccountBottomSheetState extends State<CreateAccountBottomSheet> {
  final _otpFieldController = OtpFieldController();

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
                BlocBuilder<CreateAccountCubit, CreateAccountState>(
                  builder: (context, state) {
                    return state.createAccountStep == CreateAccountStep.success
                        ? const SizedBox.shrink()
                        : const CustomBackButton();
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocConsumer<CreateAccountCubit, CreateAccountState>(
                listener: _handleListener,
                buildWhen: (previous, current) =>
                    previous.createAccountStep != current.createAccountStep,
                builder: (context, state) {
                  if (state.createAccountStep == CreateAccountStep.otp) {
                    return OtpField(
                      controller: _otpFieldController,
                      sendAction: (otp) {
                        HelperFunctions.unFocusKeyboard();
                        final errorMessage = ValidatorHelper.validateOtp(otp);
                        if (errorMessage == null) {
                          context.read<CreateAccountCubit>().checkOtp(otp);
                        } else {
                          HelperFunctions.showToastMessage(
                              context, errorMessage);
                        }
                      },
                      resendAction: () {
                        return context.read<CreateAccountCubit>().resendOtp();
                      },
                      phone: widget.phone,
                    );
                  } else if (state.createAccountStep ==
                      CreateAccountStep.create) {
                    return const CreateAccount();
                  } else {
                    return SuccessWidget(
                      action: () {
                        AppRouter.pop(context);
                        AppRouter.pushReplacementNamed(
                            context, AppRoutes.signIn);
                      },
                      title: AppStrings.signedSuccessfully.tr(),
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

  _handleListener(BuildContext context, CreateAccountState state) {
    print(state);
    if (state.showAgreeError &&
        state.createAccountStep == CreateAccountStep.create) {
      HelperFunctions.showToastMessage(
        context,
        AppStrings.pleaseAgreeToTermsAndConditions.tr(),
      );
    }
    HelperFunctions.submitActions(
      context,
      requestState: state.requestState,
      onLoaded: () {
        AppRouter.pop(context);
        if (state.createAccountStep == CreateAccountStep.otp) {
          HelperFunctions.showToastMessage(context, state.message);
        }
      },
      onError: () {
        if ((state.educationalLevel == null || state.careerLevel == null) &&
            state.createAccountStep == CreateAccountStep.create) {
          HelperFunctions.showToastMessage(context, state.message);
        } else {
          if (state.createAccountStep == CreateAccountStep.otp) {
            _otpFieldController.clear();
          }
          AppRouter.pop(context);
          HelperFunctions.showToastMessage(context, state.message);
        }
      },
    );
  }
}
