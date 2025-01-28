import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/cubit/branch/branch_cubit.dart';
import 'package:ibn_sina/cubit/city/city_cubit.dart';
import 'package:ibn_sina/cubit/settings/settings_cubit.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';

import '../../../config/locale/language_manager.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../cubit/category/category_cubit.dart';
import '../../../cubit/home_products/home_products_cubit.dart';
import '../../../cubit/home_slider/home_slider_cubit.dart';
import '../../../cubit/main/main_cubit.dart';
import '../../../cubit/my_orders/my_orders_cubit.dart';
import '../../../cubit/refresh/refresh_cubit.dart';
import '../../bottom_sheets/language_bottom_sheet.dart';
import '../../widgets/custom_back_button.dart';
import 'setting_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.settings.tr(),
        leading: CustomBackButton(
          onTap: () => context.read<MainCubit>().goToScreenWithIndex(0),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding.w,
          vertical: AppSizes.verticalPadding.h,
        ),
        physics: const BouncingScrollPhysics(),
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 30.h,
        childAspectRatio: 0.8,
        children: [
          SettingItem(
            onTap: () => _shareApp(context),
            title: AppStrings.shareApp.tr(),
            icon: SvgImages.share,
          ),
          SettingItem(
            onTap: () {
              AppRouter.pushNamed(context, AppRoutes.termsAndConditions);
            },
            title: AppStrings.termsAndConditions.tr(),
            icon: SvgImages.termsAndConditions,
          ),
          SettingItem(
            onTap: () {
              AppRouter.pushNamed(context, AppRoutes.privacyPolicy);
            },
            title: AppStrings.privacyPolicy.tr(),
            icon: SvgImages.privacy,
          ),
          SettingItem(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40.r),
                  ),
                ),
                isScrollControlled: true,
                constraints: BoxConstraints(minWidth: double.maxFinite),
                builder: (_) {
                  return LanguageBottomSheet(
                    updateLanguage: (locale) {
                      _updateLanguage(context, locale);
                    },
                  );
                },
              );
            },
            title: AppStrings.language.tr(),
            icon: SvgImages.language,
          ),
          SettingItem(
            onTap: () {
              AppRouter.pushNamed(context, AppRoutes.aboutApp);
            },
            title: AppStrings.aboutApp.tr(),
            icon: SvgImages.aboutApp,
          ),
          SettingItem(
            onTap: () {
              AppRouter.pushNamed(context, AppRoutes.contactUs);
            },
            title: AppStrings.contactUs.tr(),
            icon: SvgImages.contactUs,
          ),
          SettingItem(
            onTap: () {
              AppRouter.pushNamed(context, AppRoutes.ourBranches);
            },
            title: AppStrings.ourBranches.tr(),
            icon: SvgImages.branches,
          ),
        ],
      ),
    );
  }

  _updateLanguage(BuildContext context, Locale locale) async {
    if (LanguageManager.getCurrentLocale(context) != locale) {
      LanguageManager.changeLanugage(context, locale);
      context.read<RefreshCubit>().refresh();
      context.read<HomeSliderCubit>().getHomeSliders();
      context.read<CategoryCubit>().resetState();
      context.read<HomeProductsCubit>().resetState();
      context.read<MyOrdersCubit>().getProductOrders(refresh: true);
      context.read<BranchCubit>().getBranches();
      context.read<CityCubit>().getCities();
    }
    AppRouter.pop(context);
  }

  void _shareApp(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    if (settingsCubit.state is SettingsLoaded) {
      final settings = (settingsCubit.state as SettingsLoaded).settingsModel;
      if (Platform.isIOS) {
        HelperFunctions.shareApp(settings.appStore);
      } else {
        HelperFunctions.shareApp(settings.googlePlay);
      }
    } else {
      HelperFunctions.showAppDialog(context, child: SubmitLoading());
      settingsCubit.getAppSettings().then((data) {
        AppRouter.pop(context);
        if (data.$1 == null) {
          HelperFunctions.showToastMessage(context, data.$2);
        } else {
          if (Platform.isIOS) {
            HelperFunctions.shareApp(data.$1!.appStore);
          } else {
            HelperFunctions.shareApp(data.$1!.googlePlay);
          }
        }
      });
    }
  }
}
