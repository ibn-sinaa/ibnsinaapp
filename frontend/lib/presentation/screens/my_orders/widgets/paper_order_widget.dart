import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/cubit/my_orders/my_orders_cubit.dart';
import 'package:ibn_sina/data/models/paper_order_model.dart';
import 'package:ibn_sina/presentation/screens/my_orders/widgets/my_order_widget.dart';
import 'package:ibn_sina/presentation/widgets/row_item1.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';

class PaperOrderWidget extends StatelessWidget {
  final PaperOrderModel paperOrder;

  const PaperOrderWidget({
    super.key,
    required this.paperOrder,
  });

  @override
  Widget build(BuildContext context) {
    return MyOrderWidget(
      onPressed: () {
        AppRouter.pushNamed(
          context,
          AppRoutes.paperOrderDetails,
          arguments: paperOrder.id,
        ).then((isPaymentScreenOpened) {
          if (isPaymentScreenOpened == true) {
            context.read<MyOrdersCubit>().getPaperOrders(refresh: true);
          }
        });
      },
      orderId: paperOrder.id,
      orderStatusLabel: paperOrder.orderStatusLabel,
      totalPrice: paperOrder.prices.total,
      moreContent: Column(
        children: [
          Divider(
            height: 26.h,
          ),
          RowItem1(
            title: '✶ ${AppStrings.deliveryType.tr()}',
            content: paperOrder.deliveryType.title.tr(),
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }
}
