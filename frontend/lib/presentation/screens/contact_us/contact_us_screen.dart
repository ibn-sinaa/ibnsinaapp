import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import '../../../cubit/contact_us/contact_us_cubit.dart';
import '../../../cubit/settings/settings_cubit.dart';
import '../../../config/routes/app_router.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/error_widget.dart';
import 'widgets/contact_us_form.dart';
import 'widgets/contact_us_social_medias.dart';
import '../../widgets/custom_back_button.dart';

import '../../../config/themes/app_colors.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  final _userNameNode = FocusNode();
  final _emailNode = FocusNode();
  final _phoneNode = FocusNode();
  final _messageNode = FocusNode();
  final _formState = GlobalKey<FormState>();
  bool _isInit = true;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _userNameNode.dispose();
    _emailNode.dispose();
    _phoneNode.dispose();
    _messageNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HelperFunctions.unFocusKeyboard(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.contactUs.tr(),
          leading: const CustomBackButton(),
        ),
        body: BlocListener<ContactUsCubit, ContactUsState>(
          listener: _handleListener,
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalPadding.w,
                  vertical: AppSizes.verticalPadding.h,
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 37.h),
                      decoration: _containerDecoration(context),
                      child: Center(
                        child: Image.asset(
                          AppImages.contactUsImage,
                          height: 115.h,
                          width: 103.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 26.h, horizontal: 22.w),
                      decoration: _containerDecoration(context),
                      child: ContactUsForm(
                        userNameController: _userNameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        messageController: _messageController,
                        userNameNode: _userNameNode,
                        emailNode: _emailNode,
                        phoneNode: _phoneNode,
                        messageNode: _messageNode,
                        formState: _formState,
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    SizedBox(
                      child: CustomButton(
                        onPressed: () => context
                            .read<ContactUsCubit>()
                            .contactUs(_formState),
                        text: AppStrings.send.tr().toUpperCase(),
                        width: double.maxFinite,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                        if (state is SettingsLoading) {
                          return const InlineLoading();
                        } else if (state is SettingsError) {
                          return InlineErrorData(
                            onTap: () {
                              context.read<SettingsCubit>().getAppSettings();
                            },
                            message: state.message,
                          );
                        } else if (state is SettingsLoaded) {
                          return ContactUsSocialMedias(
                            socialModel: state.settingsModel.social,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _containerDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(9.r),
      border: Border.all(
        color: AppColors.cCCCCCC,
        width: AppSizes.borderWidth.w,
      ),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).shadowColor,
          offset: const Offset(0, 0),
          blurRadius: 2.r,
        ),
      ],
    );
  }

  _handleListener(BuildContext context, ContactUsState state) {
    if (_isInit) {
      _userNameController.text = state.userName;
      _phoneController.text = state.phone;
      if (!state.email.startsWith('loop')) {
        _emailController.text = state.email;
      }
      _isInit = false;
    }
    HelperFunctions.submitActions(
      context,
      requestState: state.requestState,
      onLoaded: () {
        AppRouter.pop(context);
        HelperFunctions.showToastMessage(context, state.requestMessage);
        _messageController.text = '';
      },
      onError: () {
        AppRouter.pop(context);
        HelperFunctions.showToastMessage(context, state.requestMessage);
      },
    );
  }
}
