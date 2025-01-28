import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/prefix_icon.dart';
import '../../../../core/helpers/validator_helper.dart';
import '../../../../cubit/sign_in/sign_in_cubit.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/password_state_icon.dart';

class SignInForm extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final FocusNode phoneNode;
  final FocusNode passwordNode;
  final GlobalKey<FormState> formState;

  const SignInForm({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.phoneNode,
    required this.passwordNode,
    required this.formState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Form(
          key: formState,
          autovalidateMode: state.showError
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              CustomTextField(
                controller: phoneController,
                focusNode: phoneNode,
                nextNode: passwordNode,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                labelText: AppStrings.phoneNumber.tr(),
                maxLength: 10,
                prefixIcon: prefixIcon(icon: SvgImages.phone),
                onChanged: context.read<SignInCubit>().phoneChanged,
                validator: ValidatorHelper.validatePhone,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                controller: passwordController,
                focusNode: passwordNode,
                labelText: AppStrings.password.tr(),
                obscureText: !state.showPassword,
                prefixIcon: prefixIcon(icon: SvgImages.lock),
                suffixIcon: PasswordStateIcon(
                  onPressed: () {
                    context.read<SignInCubit>().togglePasswordStatus();
                  },
                  showPassword: state.showPassword,
                ),
                onChanged: context.read<SignInCubit>().passwordChanged,
                validator: ValidatorHelper.validatePassword,
              ),
            ],
          ),
        );
      },
    );
  }
}
