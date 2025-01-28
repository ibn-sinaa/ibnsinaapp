import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/cubit/delete_account/delete_account_cubit.dart';
import 'package:ibn_sina/cubit/settings/settings_cubit.dart';
import 'package:ibn_sina/data/repositories/profile_repository.dart';
import 'package:ibn_sina/presentation/dialogs/delete_account_dialog.dart';
import 'package:ibn_sina/presentation/dialogs/sign_in_warnign_dialog.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';
import 'package:ibn_sina/presentation/widgets/error_widget.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import 'my_profile_item.dart';
import '../../widgets/custom_back_button.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    super.initState();
    if (context.read<SettingsCubit>().state is! SettingsLoaded &&
        Platform.isIOS) {
      context.read<SettingsCubit>().getAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.myProfile.tr(),
        leading: const CustomBackButton(),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const FetchLoading();
          } else if (state is SettingsError) {
            return ErrorData(
              onTap: () {
                context.read<SettingsCubit>().getAppSettings();
              },
              message: state.message,
            );
          } else if (state is SettingsLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding.w,
                vertical: AppSizes.verticalPadding.h,
              ),
              child: Column(
                children: [
                  MyProfileItem(
                    onTap: () {
                      AppRouter.pushNamed(context, AppRoutes.profileInfo);
                    },
                    title: AppStrings.profileInfo.tr(),
                    image: SvgImages.user,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  MyProfileItem(
                    onTap: () {
                      AppRouter.pushNamed(context, AppRoutes.changePassword);
                    },
                    title: AppStrings.changeThePassword.tr(),
                    image: SvgImages.lock,
                  ),
                  if (state.settingsModel.inReview == 1 && Platform.isIOS) ...[
                    SizedBox(
                      height: 12.h,
                    ),
                    MyProfileItem(
                      onTap: () {
                        if (locator<SharedData>().isGuest) {
                          HelperFunctions.showAppDialog<void>(
                            context,
                            barrierDismissible: true,
                            child: const SignInWarningDialog(),
                          );
                        } else {
                          HelperFunctions.showAppDialog(
                            context,
                            barrierDismissible: true,
                            child: BlocProvider<DeleteAccountCubit>(
                              create: (context) => DeleteAccountCubit(
                                locator<ProfileRepository>(),
                              ),
                              child: DeleteAccountDialog(),
                            ),
                          );
                        }
                      },
                      title: AppStrings.deleteAccount.tr(),
                      image: SvgImages.close,
                    ),
                  ],
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
