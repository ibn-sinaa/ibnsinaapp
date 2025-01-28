import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/prefix_icon.dart';
import '../../../../core/helpers/helper_functions.dart';
import 'otp_field.dart';

import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../cubit/forgot_password/forgot_password_cubit.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/password_state_icon.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _otpController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpNode = FocusNode();
  final _currentPasswordNode = FocusNode();
  final _newPasswordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _otpNode.dispose();
    _currentPasswordNode.dispose();
    _newPasswordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: AppSizes.verticalPadding.h,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text(
              AppStrings.changeThePassword.tr(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                return Form(
                  autovalidateMode: state.showError
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  key: _formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // CustomTextField(
                      //   controller: _currentPasswordController,
                      //   focusNode: _currentPasswordNode,
                      //   nextNode: _newPasswordNode,
                      //   textInputAction: TextInputAction.next,
                      //   labelText: AppStrings.currentPassword.tr(),
                      //   obscureText: true,
                      //   prefixIcon: SvgPicture.asset(SvgImages.lock),
                      //   sufixIcon: PasswordStateIcon(
                      //     onPressed: () {
                      //       context
                      //           .read<ForgotPasswordCubit>()
                      //           .toggleCurrentPasswordStatus();
                      //     },
                      //     showPassword: state.showCurrentPassword,
                      //   ),
                      //   onChanged: context
                      //       .read<ForgotPasswordCubit>()
                      //       .currentPasswordChanged,
                      //   validator: ValidatorHelper.validatePassword,
                      // ),

                      CustomTextField(
                        controller: _newPasswordController,
                        focusNode: _newPasswordNode,
                        nextNode: _confirmPasswordNode,
                        labelText: AppStrings.newPassword.tr(),
                        textInputAction: TextInputAction.next,
                        obscureText: !state.showNewPassword,
                        prefixIcon: prefixIcon(icon: SvgImages.lock),
                        suffixIcon: PasswordStateIcon(
                          onPressed: () {
                            context
                                .read<ForgotPasswordCubit>()
                                .toggleNewPasswordStatus();
                          },
                          showPassword: state.showNewPassword,
                        ),
                        onChanged: context
                            .read<ForgotPasswordCubit>()
                            .newPasswordChanged,
                        validator: ValidatorHelper.validatePassword,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordNode,
                        nextNode: _otpNode,
                        labelText: AppStrings.confirmNewPassword.tr(),
                        textInputAction: TextInputAction.next,
                        obscureText: !state.showConfirmNewPassword,
                        prefixIcon: prefixIcon(icon: SvgImages.lock),
                        suffixIcon: PasswordStateIcon(
                          onPressed: () {
                            context
                                .read<ForgotPasswordCubit>()
                                .toggleConfirmNewPasswordStatus();
                          },
                          showPassword: state.showConfirmNewPassword,
                        ),
                        onChanged: context
                            .read<ForgotPasswordCubit>()
                            .confirmNewPasswordChanged,
                        validator: (confirmNewPassword) =>
                            ValidatorHelper.validateConfirmPassword(
                          confirmNewPassword,
                          context.read<ForgotPasswordCubit>().state.newPassword,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        controller: _otpController,
                        focusNode: _otpNode,
                        labelText: AppStrings.verificationCode.tr(),
                        keyboardType: TextInputType.number,
                        prefixIcon: SvgPicture.asset(
                          SvgImages.otp,
                          width: 16.w,
                          colorFilter: AppColors.colorFilter(
                              Theme.of(context).colorScheme.secondary),
                        ),
                        onChanged:
                            context.read<ForgotPasswordCubit>().otpChanged,
                        validator: ValidatorHelper.validateOtp1,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      OtpTimer(() {
                        return context.read<ForgotPasswordCubit>().resendOtp();
                      })
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 70.h,
            ),
            CustomButton(
              onPressed: () {
                HelperFunctions.unFocusKeyboard();
                context
                    .read<ForgotPasswordCubit>()
                    .createNewPassword(_formState);
              },
              text: AppStrings.confirm.tr().toUpperCase(),
              width: double.maxFinite,
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
