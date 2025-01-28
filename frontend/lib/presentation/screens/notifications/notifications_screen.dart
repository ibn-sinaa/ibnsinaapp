import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/enums.dart';
import '../../../cubit/notifications/notifications_cubit.dart';
import '../../../cubit/notifications_count/notifications_count_cubit.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/no_data.dart';
import 'widgets/notification_item_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsCountCubit, int>(
      listener: (context, count) {
        if (count > 0) {
          context.read<NotificationsCubit>().getNotifications();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.notifications.tr(),
          leading: CustomBackButton(
            onTap: () {
              if (AppRouter.canPop(context)) {
                AppRouter.pop(context);
              } else {
                AppRouter.pushReplacementNamed(context, AppRoutes.main);
              }
            },
          ),
        ),
        body: BlocConsumer<NotificationsCubit, NotificationsState>(
          listener: (context, state) {
            if (state.moreState == RequestState.error ||
                state.deleteState == RequestState.error ||
                state.deleteState == RequestState.loaded) {
              HelperFunctions.showToastMessage(context, state.message);
            }
            if (state.requestState == RequestState.loaded) {
              context.read<NotificationsCountCubit>().resetNotificationsCount();
            }
          },
          builder: (context, state) {
            if (state.requestState == RequestState.loading) {
              return const FetchLoading();
            } else if (state.requestState == RequestState.error) {
              return Center(
                child: ErrorData(
                  onTap: () {
                    context.read<NotificationsCubit>().getNotifications();
                  },
                  message: state.message,
                ),
              );
            } else if (state.requestState == RequestState.loaded) {
              return state.notifications.isEmpty
                  ? Center(
                      child: NoData(
                        title: AppStrings.noNotifications.tr(),
                      ),
                    )
                  : NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels >=
                            notification.metrics.maxScrollExtent) {
                          context
                              .read<NotificationsCubit>()
                              .loadMoreNotifications();
                        }
                        return true;
                      },
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<NotificationsCubit>().getNotifications();
                        },
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.horizontalPadding.w,
                            vertical: AppSizes.verticalPadding.h,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                NotificationItemWidget(
                                  notificationModel: state.notifications[index],
                                ),
                                SizedBox(
                                  height: 13.5.h,
                                ),
                                if (state.moreState == RequestState.loading &&
                                    index == state.notifications.length - 1)
                                  const InlineLoading()
                              ],
                            );
                          },
                          separatorBuilder: (_, __) {
                            return SizedBox(
                              height: 8.h,
                            );
                          },
                          itemCount: state.notifications.length,
                        ),
                      ),
                    );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
