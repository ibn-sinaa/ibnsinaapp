import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/services/notification_service.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../data/repositories/auth_repository.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../cubit/forgot_password/forgot_password_cubit.dart';
import '../../../../cubit/sign_in/sign_in_cubit.dart';
import '../widgets/auth_body.dart';
import '../widgets/auth_bottom_part.dart';
import '../widgets/forgot_password_bottom_sheet.dart';
import '../widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNode = FocusNode();
  final _passwordNode = FocusNode();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        _handleListener(state);
      },
      child: AuthBody(
        title: AppStrings.welcomeBack.tr(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SignInForm(
              phoneController: _phoneController,
              passwordController: _passwordController,
              phoneNode: _phoneNode,
              passwordNode: _passwordNode,
              formState: _formState,
            ),
            SizedBox(
              height: 12.h,
            ),
            TextButton(
              onPressed: _showForgotPasswordBottomSheet,
              child: Text(AppStrings.forgotPassword.tr()),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  fontSize:
                      getValueForScreenType(context, medium: 14, large: 15).sp,
                ),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () => context.read<SignInCubit>().signIn(_formState),
                text: AppStrings.sign.tr().toUpperCase(),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            AuthBottomPart(
              onTap: () =>
                  AppRouter.pushReplacementNamed(context, AppRoutes.signUp),
              text1: AppStrings.donnotHaveAnAccount.tr(),
              text2: AppStrings.createAccount.tr(),
            ),
            SizedBox(
              height: 24.h,
            ),
            Center(
              child: CustomButton(
                onPressed: () {
                  context.read<SignInCubit>().signIn(_formState, isGuest: true);
                },
                text: AppStrings.signInAsAguest.tr(),
                backgroundColor: AppColors.cF5F5F5,
                foregroundColor: AppColors.c848484,
              ),
            ),
            // SizedBox(
            //   height: 43.h,
            // ),
            // Center(
            //   child: TextButton(
            //     onPressed: () => AppRouter.offNamed(context, AppRoutes.main),
            //     child: Text(
            //       AppStrings.discoverIbnSina.tr(),
            //       style: TextStyle(
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.w500,
            //         color: AppColors.c2D2F3A,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  _showForgotPasswordBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      constraints: BoxConstraints(minWidth: double.maxFinite),
      builder: (context) {
        return BlocProvider<ForgotPasswordCubit>(
          create: (context) => ForgotPasswordCubit(
            locator<AuthRepository>(),
          ),
          child: const ForgotPasswordBottomSheet(),
        );
      },
    );
  }

  _handleListener(SignInState state) {
    HelperFunctions.submitActions(
      context,
      requestState: state.requestState,
      onLoaded: () {
        AppRouter.pop(context);
        AppRouter.pushReplacementNamed(context, AppRoutes.main);
        if (!locator<SharedData>().isGuest) {
          NotificationService.subscribeToTopic();
        }
      },
      onError: () {
        AppRouter.pop(context);
        HelperFunctions.showToastMessage(context, state.message);
      },
    );
  }
}
