import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/cubit/cart/cart_cubit.dart';
import 'package:ibn_sina/cubit/order_completion/order_completion_cubit.dart';
import 'package:ibn_sina/presentation/bottom_sheets/price_summery_bottom_sheet.dart';
import 'package:ibn_sina/presentation/screens/order_completion/order_completion_screen.dart';
import 'package:ibn_sina/presentation/screens/order_completion/widgets/product_summery.dart';

class ProductCompletionScreen extends StatelessWidget {
  const ProductCompletionScreen({
    super.key,
    required this.cartState,
  });

  final CartState cartState;

  @override
  Widget build(BuildContext context) {
    return OrderCompletionScreen(
      orderType: OrderType.product,
      summerySheet: BlocBuilder<OrderCompletionCubit, OrderCompletionState>(
          buildWhen: (previous, current) =>
              previous.deliveryType != current.deliveryType,
          builder: (context, state) {
            final tax =
                (locator<SharedData>().tax! / 100) * cartState.totalValue;
            final shippingCost = state.deliveryType.isHome()
                ? locator<SharedData>().shippingCost!
                : 0;
            final totalPriceAfterTax =
                cartState.totalValue + tax + shippingCost;
            return PriceSummeryBottomSheet(
              onTap: () {
                context.read<OrderCompletionCubit>().makeProductOrder(
                      cartItems: cartState.cartItems,
                      couponId: cartState.couponId,
                    );
              },
              totalValue: totalPriceAfterTax,
              hasFixedHeight: false,
              content: ProductSummery(
                orderValue: cartState.orderValue,
                orderValueAfterDiscount: cartState.orderValueAfterDiscount,
                addedValue: tax,
                discountValue: cartState.discountValue,
                shippingCost: shippingCost,
                deliveryType: state.deliveryType,
              ),
            );
          }),
    );
  }
}
