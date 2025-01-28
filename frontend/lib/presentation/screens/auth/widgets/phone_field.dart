import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/prefix_icon.dart';

import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../cubit/forgot_password/forgot_password_cubit.dart';
import '../../../widgets/custom_text_field.dart';

class PhoneField extends StatefulWidget {
  const PhoneField({super.key});

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  final _phoneController = TextEditingController();
  final _phoneNode = FocusNode();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneNode.dispose();
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
            Text(
              AppStrings.enterYourPhoneNumber.tr(),
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
                      CustomTextField(
                        controller: _phoneController,
                        focusNode: _phoneNode,
                        keyboardType: TextInputType.phone,
                        labelText: AppStrings.phoneNumber.tr(),
                        maxLength: 10,
                        prefixIcon: prefixIcon(icon: SvgImages.phone),
                        onChanged:
                            context.read<ForgotPasswordCubit>().phoneChanged,
                        validator: ValidatorHelper.validatePhone,
                      ),
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
                context.read<ForgotPasswordCubit>().forgotPassword(_formState);
              },
              text: AppStrings.send.tr(),
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
