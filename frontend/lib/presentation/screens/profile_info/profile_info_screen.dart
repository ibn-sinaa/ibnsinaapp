import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/presentation/dialogs/sign_in_warnign_dialog.dart';
import 'package:ibn_sina/presentation/widgets/career_level_dropdown.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/educationl_level_dropdown.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import 'widgets/profile_image.dart';
import '../../widgets/custom_back_button.dart';

import '../../../config/routes/app_router.dart';
import '../../../core/helpers/validator_helper.dart';
import '../../../core/utils/enums.dart';
import '../../../cubit/my_profile/my_profile_cubit.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/error_widget.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameNode = FocusNode();
  final _emailNode = FocusNode();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _userNameNode.dispose();
    _emailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HelperFunctions.unFocusKeyboard(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.profileInfo.tr(),
          leading: const CustomBackButton(),
        ),
        body: BlocConsumer<MyProfileCubit, MyProfileState>(
          listener: (context, state) {
            _handleListener(state);
          },
          builder: (context, state) {
            if (state.requestState == RequestState.loading) {
              return const FetchLoading();
            } else if (state.requestState == RequestState.error) {
              return ErrorData(
                onTap: () {
                  context.read<MyProfileCubit>().getMyProfile();
                },
                message: state.message,
              );
            } else if (state.requestState == RequestState.loaded) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalPadding.w,
                  vertical: AppSizes.verticalPadding.h,
                ),
                child: Column(
                  children: [
                    ProfileImage(
                      onUpdated: (filePath) {
                        return context
                            .read<MyProfileCubit>()
                            .saveProfileImage(filePath);
                      },
                      image: state.image,
                    ),
                    SizedBox(
                      height: 63.h,
                    ),
                    AbsorbPointer(
                      absorbing: !state.enableUpdating,
                      child: Opacity(
                        opacity: state.enableUpdating ? 1 : 0.7,
                        child: Form(
                          autovalidateMode: state.showError
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          key: _formState,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _userNameController,
                                focusNode: _userNameNode,
                                nextNode: _emailNode,
                                textInputAction: TextInputAction.next,
                                labelText: AppStrings.userName.tr(),
                                onChanged: context
                                    .read<MyProfileCubit>()
                                    .userNameChanged,
                                validator: ValidatorHelper.validateUserName,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustomTextField(
                                controller: _emailController,
                                focusNode: _emailNode,
                                keyboardType: TextInputType.emailAddress,
                                labelText: AppStrings.email.tr(),
                                onChanged:
                                    context.read<MyProfileCubit>().emailChanged,
                                validator: ValidatorHelper.validateEmailAddress,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              EducationalLevelDropdown(
                                selectedLevel: state.educationalLevel,
                                onEducationalLevelChanged: (value) => context
                                    .read<MyProfileCubit>()
                                    .educationalLevelChanged(value!),
                                universityName: state.universityName,
                                onUniversityNameChanged: context
                                    .read<MyProfileCubit>()
                                    .universityNameChanged,
                                universityNameVidator: (value) =>
                                    ValidatorHelper.validateText(
                                  value,
                                  AppStrings.universityNameIsRequired.tr(),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CareerLevelsDropdown(
                                selectedCareerLevel: state.careerLevel,
                                onChanged: (value) => context
                                    .read<MyProfileCubit>()
                                    .careerLevelChanged(value!),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    CustomButton(
                      onPressed: () {
                        if (locator<SharedData>().isGuest) {
                          HelperFunctions.unFocusKeyboard();
                          HelperFunctions.showAppDialog<void>(
                            context,
                            barrierDismissible: true,
                            child: const SignInWarningDialog(),
                          );
                        } else {
                          if (state.enableUpdating) {
                            context
                                .read<MyProfileCubit>()
                                .saveNewInfo(_formState);
                          } else {
                            context.read<MyProfileCubit>().enableUpdate();
                          }
                        }
                      },
                      text: state.enableUpdating
                          ? AppStrings.save.tr().toUpperCase()
                          : AppStrings.update.tr().toUpperCase(),
                      width: double.maxFinite,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  _handleListener(MyProfileState state) {
    if (state.enableUpdating == false &&
        _userNameController.text.isEmpty &&
        state.requestState == RequestState.loaded) {
      _userNameController.text = state.userName;
      _emailController.text = state.email;
    }
    if (state.requestState == RequestState.loaded) {
      HelperFunctions.submitActions(
        context,
        requestState: state.updateState,
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
}
