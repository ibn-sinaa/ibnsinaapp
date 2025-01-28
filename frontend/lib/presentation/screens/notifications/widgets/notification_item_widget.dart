import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/locale/language_manager.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/enums.dart';
import '../../../../cubit/notifications/notifications_cubit.dart';
import '../../../../data/models/notification_model.dart';
import '../../../dialogs/notification_details_dialog.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/square_icon.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../widgets/custom_shadow_container.dart';

class NotificationItemWidget extends StatefulWidget {
  final NotificationModel notificationModel;

  const NotificationItemWidget({
    super.key,
    required this.notificationModel,
  });

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  int _deletedId = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HelperFunctions.showAppDialog(
          context,
          barrierDismissible: true,
          child: NotificationDetailsDialog(
            title: widget.notificationModel.title,
            message: widget.notificationModel.message,
          ),
        );
      },
      child: CustomShadowContainer(
        padding: EdgeInsets.only(
          left: LanguageManager.isEnglish(context) ? 12.w : 0,
          right: LanguageManager.isEnglish(context) ? 0 : 12.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: SvgPicture.asset(
                SvgImages.notification,
                width: 18.w,
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.notificationModel.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.c2D2F3A,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      widget.notificationModel.message,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.c919191,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      widget.notificationModel.createdAt,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.c919191,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 6.w,
            ),
            BlocBuilder<NotificationsCubit, NotificationsState>(
              buildWhen: (previous, current) =>
                  previous.deleteState != current.deleteState,
              builder: (context, state) {
                return (state.deleteState == RequestState.loading &&
                        widget.notificationModel.id == _deletedId)
                    ? Padding(
                        padding: EdgeInsets.all(10.w),
                        child: const InlineLoading(),
                      )
                    : SquareIcon(
                        onPressed: () {
                          _deletedId = widget.notificationModel.id;
                          context
                              .read<NotificationsCubit>()
                              .deleteNotification(_deletedId);
                        },
                        icon: Icons.delete,
                        color: AppColors.cEF5350,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
