import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../cubit/contact_us/contact_us_cubit.dart';
import '../../../widgets/custom_text_field.dart';

class ContactUsForm extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController messageController;
  final FocusNode userNameNode;
  final FocusNode emailNode;
  final FocusNode phoneNode;
  final FocusNode messageNode;
  final GlobalKey<FormState> formState;

  const ContactUsForm({
    super.key,
    required this.userNameController,
    required this.emailController,
    required this.phoneController,
    required this.messageController,
    required this.userNameNode,
    required this.emailNode,
    required this.phoneNode,
    required this.messageNode,
    required this.formState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsCubit, ContactUsState>(
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showError
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          key: formState,
          child: Column(
            children: [
              CustomTextField(
                controller: userNameController,
                focusNode: userNameNode,
                nextNode: phoneNode,
                textInputAction: TextInputAction.next,
                labelText: AppStrings.userName.tr(),
                onChanged: context.read<ContactUsCubit>().userNameChanged,
                validator: (userName) => ValidatorHelper.validateText(
                  userName,
                  AppStrings.userNameIsRequired.tr(),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                controller: phoneController,
                focusNode: phoneNode,
                nextNode: emailNode,
                keyboardType: TextInputType.phone,
                labelText: AppStrings.phoneNumber.tr(),
                maxLength: 10,
                textInputAction: TextInputAction.next,
                onChanged: context.read<ContactUsCubit>().phoneChanged,
                validator: ValidatorHelper.validatePhone,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                controller: emailController,
                focusNode: emailNode,
                nextNode: messageNode,
                keyboardType: TextInputType.emailAddress,
                labelText: AppStrings.email.tr(),
                textInputAction: TextInputAction.next,
                onChanged: context.read<ContactUsCubit>().emailChanged,
                validator: ValidatorHelper.validateEmailAddress,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                controller: messageController,
                focusNode: messageNode,
                textInputAction: TextInputAction.newline,
                labelText: AppStrings.messageContent.tr(),
                maxLines: 4,
                onChanged: context.read<ContactUsCubit>().messageChanged,
                validator: (message) => ValidatorHelper.validateText(
                  message,
                  AppStrings.messageIsRequired.tr(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
