import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../cubit/send_quotation_request/send_quotation_request_cubit.dart';
import '../../../bottom_sheets/success_bottom_sheet.dart';
import '../../../widgets/custom_text_field.dart';

class SendQuotationRequestForm extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController messageController;
  final FocusNode userNameNode;
  final FocusNode emailNode;
  final FocusNode phoneNode;
  final FocusNode messageNode;
  final GlobalKey<FormState> formState;

  const SendQuotationRequestForm({
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
    return BlocConsumer<SendQuotationRequestCubit, SendQuotationRequestState>(
      listener: _handleListener,
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
                onChanged:
                    context.read<SendQuotationRequestCubit>().userNameChanged,
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
                textInputAction: TextInputAction.next,
                maxLength: 10,
                onChanged:
                    context.read<SendQuotationRequestCubit>().phoneChanged,
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
                onChanged:
                    context.read<SendQuotationRequestCubit>().emailChanged,
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
                onChanged:
                    context.read<SendQuotationRequestCubit>().messageChanged,
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

  _handleListener(BuildContext context, SendQuotationRequestState state) {
    HelperFunctions.submitActions(
      context,
      requestState: state.requestState,
      onLoaded: () {
        AppRouter.pop(context);
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.r),
            ),
          ),
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: false,
          constraints: BoxConstraints(minWidth: double.maxFinite),
          builder: (context) {
            return SuccessBottomSheet(
              action: () {
                AppRouter.pop(context);
                AppRouter.pop(context);
              },
              title: AppStrings.requestSentSuccessfully.tr(),
            );
          },
        );
      },
      onError: () {
        AppRouter.pop(context);
        HelperFunctions.showToastMessage(context, state.requestMessage);
      },
    );
  }
}
