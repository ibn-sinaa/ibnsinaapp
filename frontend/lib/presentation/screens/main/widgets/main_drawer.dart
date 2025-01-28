import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/services/notification_service.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../../cubit/user/user_cubit.dart';

import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/custom_shadow_container.dart';

import '../../../widgets/cached_image.dart';
import 'drawer_item.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: AppSizes.verticalPadding.h + ScreenUtil().statusBarHeight,
        bottom: AppSizes.verticalPadding.h,
        left: AppSizes.horizontalPadding.w,
        right: AppSizes.horizontalPadding.w,
      ),
      width: ScreenUtil().screenWidth * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 57.h,
          horizontal: 16.w,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackButton(),
                SizedBox(
                  width:
                      getValueForScreenType(context, medium: 50, large: 60).w,
                ),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    final imageSize = getValueForScreenType(context,
                        medium: 103.0, large: 90.0);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomShadowContainer(
                          padding: EdgeInsets.all(5.w),
                          radius: 103,
                          child: CachedImage(
                            imageUrl: state.image,
                            width: imageSize,
                            height: imageSize,
                            memCacheHeight: imageSize.w.cacheSize(context),
                            memCacheWidth: imageSize.w.cacheSize(context),
                            radius: imageSize,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          state.userName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
            SizedBox(
              height: 64.h,
            ),
            DrawerItem(
              onTap: () {
                AppRouter.pushNamed(context, AppRoutes.myProfile);
              },
              image: SvgImages.user,
              title: AppStrings.myProfile.tr(),
            ),
            SizedBox(
              height: 24.h,
            ),
            DrawerItem(
              onTap: () {
                AppRouter.pushNamed(context, AppRoutes.quotaionRequests);
              },
              image: SvgImages.requests,
              title: AppStrings.quotationRequests.tr(),
            ),
            SizedBox(
              height: 24.h,
            ),
            DrawerItem(
              onTap: () {
                AppRouter.pushNamed(context, AppRoutes.paperPrintingOrders);
              },
              image: SvgImages.paper,
              title: AppStrings.paperPrintingRequests.tr(),
            ),
            SizedBox(
              height: 24.h,
            ),
            DrawerItem(
              onTap: () {
                AppRouter.pushNamed(context, AppRoutes.mediaPrintingOrders);
              },
              image: SvgImages.banner,
              title: AppStrings.largeMediaPrinting.tr(),
            ),
            // const Spacer(),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: context.read<UserCubit>().signOut,
              child: SizedBox(
                height: 80.w,
                width: 80.w,
                child: Card(
                  child: BlocConsumer<UserCubit, UserState>(
                    listener: (context, state) {
                      if (state.requestState == RequestState.error ||
                          state.requestState == RequestState.loaded) {
                        HelperFunctions.showToastMessage(
                            context, state.message);
                      }
                      if (state.requestState == RequestState.loaded) {
                        AppRouter.pushReplacementNamed(
                            context, AppRoutes.signIn);
                        NotificationService.unsubscribeFromTopic();
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: state.requestState == RequestState.loading
                            ? const InlineLoading()
                            : SvgPicture.asset(
                                SvgImages.signOut,
                                width: 20.w,
                                height: 20.w,
                              ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 13.h,
            ),
            Text(
              AppStrings.signOut.tr(),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
