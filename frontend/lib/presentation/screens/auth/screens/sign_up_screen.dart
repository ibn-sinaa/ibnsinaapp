import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/prefix_icon.dart';
import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../data/repositories/auth_repository.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../cubit/create_account/create_account_cubit.dart';
import '../../../../cubit/sign_up/sign_up_cubit.dart';
import '../../../widgets/custom_text_field.dart';
import '../widgets/auth_body.dart';
import '../widgets/auth_bottom_part.dart';
import '../widgets/create_account_bottom_sheet.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
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
    return AuthBody(
      title: AppStrings.createAccount.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              _handleListener(state);
            },
            builder: (context, state) {
              return Form(
                autovalidateMode: state.showError
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                key: _formState,
                child: CustomTextField(
                  controller: _phoneController,
                  focusNode: _phoneNode,
                  keyboardType: TextInputType.phone,
                  labelText: AppStrings.phoneNumber.tr(),
                  maxLength: 10,
                  prefixIcon: prefixIcon(icon: SvgImages.phone),
                  onChanged: context.read<SignUpCubit>().phoneChanged,
                  validator: ValidatorHelper.validatePhone,
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
                context.read<SignUpCubit>().registerPhone(_formState);
              },
              text: AppStrings.register.tr().toUpperCase(),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          AuthBottomPart(
            onTap: () =>
                AppRouter.pushReplacementNamed(context, AppRoutes.signIn),
            text1: AppStrings.haveAccount.tr(),
            text2: AppStrings.signIn.tr(),
          ),
        ],
      ),
    );
  }

  _handleListener(SignUpState state) {
    HelperFunctions.submitActions(
      context,
      requestState: state.requestState,
      onLoaded: () {
        AppRouter.pop(context);
        HelperFunctions.showToastMessage(context, state.message);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          enableDrag: false,
          isDismissible: false,
          constraints: BoxConstraints(minWidth: double.maxFinite),
          builder: (context) {
            return BlocProvider<CreateAccountCubit>(
              create: (context) => CreateAccountCubit(
                locator<AuthRepository>(),
                state.phone,
              ),
              child: CreateAccountBottomSheet(
                phone: state.phone,
              ),
            );
          },
        );
      },
      onError: () {
        AppRouter.pop(context);
        HelperFunctions.showToastMessage(context, state.message);
      },
    );
  }
}
