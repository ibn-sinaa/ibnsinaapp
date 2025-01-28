import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/presentation/widgets/career_level_dropdown.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/educationl_level_dropdown.dart';
import 'package:ibn_sina/presentation/widgets/prefix_icon.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../cubit/create_account/create_account_cubit.dart';
import '../../../widgets/custom_check_box.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/password_state_icon.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userNameNode = FocusNode();
  final _passwordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: AppSizes.verticalPadding.h,
      ),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Text(
            AppStrings.accountInfo.tr(),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(
            height: 70.h,
          ),
          BlocBuilder<CreateAccountCubit, CreateAccountState>(
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
                      controller: _userNameController,
                      focusNode: _userNameNode,
                      nextNode: _passwordNode,
                      textInputAction: TextInputAction.next,
                      labelText: AppStrings.userName.tr(),
                      prefixIcon: prefixIcon(icon: SvgImages.user),
                      onChanged:
                          context.read<CreateAccountCubit>().userNameChanged,
                      validator: ValidatorHelper.validateUserName,
                    ),
                    SizedBox(
                      height:
                          getValueForScreenType(context, medium: 20, large: 28)
                              .h,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      focusNode: _passwordNode,
                      nextNode: _confirmPasswordNode,
                      labelText: AppStrings.password.tr(),
                      textInputAction: TextInputAction.next,
                      obscureText: !state.showPassword,
                      prefixIcon: prefixIcon(icon: SvgImages.lock),
                      suffixIcon: PasswordStateIcon(
                        onPressed: () {
                          context
                              .read<CreateAccountCubit>()
                              .togglePasswordStatus();
                        },
                        showPassword: state.showPassword,
                      ),
                      onChanged:
                          context.read<CreateAccountCubit>().passwordChanged,
                      validator: ValidatorHelper.validatePassword,
                    ),
                    SizedBox(
                      height:
                          getValueForScreenType(context, medium: 20, large: 28)
                              .h,
                    ),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordNode,
                      labelText: AppStrings.confirmPassword.tr(),
                      obscureText: !state.showConfirmPassword,
                      prefixIcon: prefixIcon(icon: SvgImages.lock),
                      suffixIcon: PasswordStateIcon(
                        onPressed: () {
                          context
                              .read<CreateAccountCubit>()
                              .toggleConfirmPPasswordStatus();
                        },
                        showPassword: state.showConfirmPassword,
                      ),
                      onChanged: context
                          .read<CreateAccountCubit>()
                          .confirmPasswordChanged,
                      validator: (confirmPassword) =>
                          ValidatorHelper.validateConfirmPassword(
                        confirmPassword,
                        context.read<CreateAccountCubit>().state.password,
                      ),
                    ),
                    SizedBox(
                      height:
                          getValueForScreenType(context, medium: 20, large: 28)
                              .h,
                    ),
                    EducationalLevelDropdown(
                      selectedLevel: state.educationalLevel,
                      onEducationalLevelChanged: (value) => context
                          .read<CreateAccountCubit>()
                          .educationalLevelChanged(value!),
                      onUniversityNameChanged: context
                          .read<CreateAccountCubit>()
                          .universityNameChanged,
                      universityNameVidator: (value) =>
                          ValidatorHelper.validateText(
                        value,
                        AppStrings.universityNameIsRequired.tr(),
                      ),
                    ),
                    SizedBox(
                      height:
                          getValueForScreenType(context, medium: 20, large: 28)
                              .h,
                    ),
                    CareerLevelsDropdown(
                      selectedCareerLevel: state.careerLevel,
                      onChanged: (value) => context
                          .read<CreateAccountCubit>()
                          .careerLevelChanged(value!),
                      apiToken: context.read<CreateAccountCubit>().apiToken,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    CustomCheckBox(
                      onChanged: (_) {
                        context.read<CreateAccountCubit>().toggleAgreeStatus();
                      },
                      isChecked: state.isAgree,
                      title: AppStrings.agreeToTermsAndConditions.tr(),
                      titleStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.secondary,
                        height: 1.5,
                        decoration: TextDecoration.underline,
                      ),
                      onTap: () {
                        AppRouter.pushNamed(
                          context,
                          AppRoutes.termsAndConditions,
                          arguments:
                              context.read<CreateAccountCubit>().apiToken,
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 70.h,
          ),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: () {
                HelperFunctions.unFocusKeyboard();
                context.read<CreateAccountCubit>().createAccount(_formState);
              },
              text: AppStrings.register.tr().toUpperCase(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
        ],
      ),
    );
  }
}
