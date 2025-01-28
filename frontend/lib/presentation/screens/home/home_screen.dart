import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/cubit/refresh/refresh_cubit.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../cubit/main/main_cubit.dart';
import '../../../cubit/notifications_count/notifications_count_cubit.dart';
import '../../../cubit/user/user_cubit.dart';
import '../../widgets/custom_icon_button.dart';
import 'widgets/home_body.dart';
import 'widgets/notification_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefreshCubit, bool>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => HelperFunctions.unFocusKeyboard(),
          child: Scaffold(
            appBar: CustomAppBar(
              centerTitle: false,
              customTitle: GestureDetector(
                onTap: () {
                  HelperFunctions.unFocusKeyboard();
                  context
                      .read<MainCubit>()
                      .scaffoldKey
                      .currentState!
                      .openDrawer();
                },
                child: Container(
                  color: Colors.transparent,
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconButton(
                            onTap: () {
                              context
                                  .read<MainCubit>()
                                  .scaffoldKey
                                  .currentState!
                                  .openDrawer();
                            },
                            icon: SvgImages.menu,
                            iconColor: Theme.of(context).colorScheme.secondary,
                            size: 16,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.heyYou.tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Text(
                                state.userName,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding.w,
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        CustomIconButton(
                          onTap: () {
                            AppRouter.pushNamed(
                                context, AppRoutes.notifications);
                          },
                          icon: SvgImages.notification,
                        ),
                        BlocBuilder<NotificationsCountCubit, int>(
                          builder: (context, count) {
                            return count > 0
                                ? Positioned(
                                    top: 10.h,
                                    right: 5.w,
                                    child: NotificationIcon(count: count),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            body: const HomeBody(),
          ),
        );
      },
    );
  }
}
