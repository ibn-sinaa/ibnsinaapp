import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/cubit/my_orders/my_orders_cubit.dart';
import 'package:ibn_sina/presentation/screens/my_orders/widgets/my_order_widget.dart';
import 'package:ibn_sina/presentation/widgets/row_item1.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../data/models/product_order_model.dart';
import '../../../widgets/row_item.dart';

class ProductOrderWidget extends StatelessWidget {
  final ProductOrderModel productOrder;

  const ProductOrderWidget({
    super.key,
    required this.productOrder,
  });

  @override
  Widget build(BuildContext context) {
    return MyOrderWidget(
      onPressed: () {
        AppRouter.pushNamed(
          context,
          AppRoutes.productOrderDetails,
          arguments: productOrder.id,
        ).then((isPaymentScreenOpened) {
          if (isPaymentScreenOpened == true) {
            context.read<MyOrdersCubit>().getProductOrders(refresh: true);
          }
        });
      },
      orderId: productOrder.id,
      orderStatusLabel: productOrder.orderStatusLabel,
      totalPrice: productOrder.prices.total,
      moreContent: Column(
        children: [
          const Divider(),
          SizedBox(
            height: 8.h,
          ),
          ...productOrder.items.map(
            (product) => Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productId.title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    RowItem(
                      title: AppStrings.quantity.tr(),
                      content: '(${product.amount.toStringAsFixed(0)})',
                      fontSize: 11,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
                const Divider(),
                RowItem1(
                  title: '✶ ${AppStrings.deliveryType.tr()}',
                  content: productOrder.deliveryType.title.tr(),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
