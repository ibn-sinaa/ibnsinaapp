import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/presentation/dialogs/sign_in_warnign_dialog.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/prefix_icon.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../widgets/custom_back_button.dart';

import '../../../../core/utils/app_images.dart';
import '../../../config/routes/app_router.dart';
import '../../../core/helpers/validator_helper.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../cubit/change_password/change_password_cubit.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/password_state_icon.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _currentPasswordNode = FocusNode();
  final _newPasswordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentPasswordNode.dispose();
    _newPasswordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HelperFunctions.unFocusKeyboard(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.changeThePassword.tr(),
          leading: const CustomBackButton(),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding.w,
            vertical: AppSizes.verticalPadding.h,
          ),
          child: Column(
            children: [
              BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                listener: (context, state) {
                  _handleListener(state);
                },
                builder: (context, state) {
                  return Form(
                    autovalidateMode: state.showError
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    key: _formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: _currentPasswordController,
                          focusNode: _currentPasswordNode,
                          nextNode: _newPasswordNode,
                          textInputAction: TextInputAction.next,
                          labelText: AppStrings.currentPassword.tr(),
                          obscureText: !state.showCurrentPassword,
                          prefixIcon: prefixIcon(icon: SvgImages.lock),
                          suffixIcon: PasswordStateIcon(
                            onPressed: () {
                              context
                                  .read<ChangePasswordCubit>()
                                  .toggleCurrentPasswordStatus();
                            },
                            showPassword: state.showCurrentPassword,
                          ),
                          onChanged: context
                              .read<ChangePasswordCubit>()
                              .currentPasswordChanged,
                          validator: ValidatorHelper.validatePassword,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
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
                                  .read<ChangePasswordCubit>()
                                  .toggleNewPasswordStatus();
                            },
                            showPassword: state.showNewPassword,
                          ),
                          onChanged: context
                              .read<ChangePasswordCubit>()
                              .newPasswordChanged,
                          validator: ValidatorHelper.validatePassword,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordNode,
                          labelText: AppStrings.confirmNewPassword.tr(),
                          obscureText: !state.showConfirmNewPassword,
                          prefixIcon: prefixIcon(icon: SvgImages.lock),
                          suffixIcon: PasswordStateIcon(
                            onPressed: () {
                              context
                                  .read<ChangePasswordCubit>()
                                  .toggleConfirmNewPasswordStatus();
                            },
                            showPassword: state.showConfirmNewPassword,
                          ),
                          onChanged: context
                              .read<ChangePasswordCubit>()
                              .confirmNewPasswordChanged,
                          validator: (confirmNewPassword) =>
                              ValidatorHelper.validateConfirmPassword(
                            confirmNewPassword,
                            context
                                .read<ChangePasswordCubit>()
                                .state
                                .newPassword,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 70.h,
              ),
              SizedBox(
                child: CustomButton(
                  onPressed: () {
                    if (locator<SharedData>().isGuest) {
                      HelperFunctions.unFocusKeyboard();
                      HelperFunctions.showAppDialog<void>(
                        context,
                        barrierDismissible: true,
                        child: const SignInWarningDialog(),
                      );
                    } else {
                      HelperFunctions.unFocusKeyboard();
                      context
                          .read<ChangePasswordCubit>()
                          .changePassword(_formState);
                    }
                  },
                  text: AppStrings.confirm.tr().toUpperCase(),
                  width: double.maxFinite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleListener(ChangePasswordState state) {
    HelperFunctions.submitActions(
      context,
      requestState: state.requestState,
      onLoaded: () {
        AppRouter.pop(context);
        HelperFunctions.showToastMessage(context, state.message);
      },
      onError: () {
        AppRouter.pop(context);
        HelperFunctions.showToastMessage(context, state.message);
      },
    );
  }
}
