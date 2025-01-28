import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/cubit/media_printing/media_printing_cubit.dart';
import 'package:ibn_sina/cubit/order_completion/order_completion_cubit.dart';
import 'package:ibn_sina/presentation/bottom_sheets/price_summery_bottom_sheet.dart';
import 'package:ibn_sina/presentation/screens/order_completion/widgets/media_printing_summery.dart';
import 'package:ibn_sina/presentation/screens/order_completion/order_completion_screen.dart';

class MediaCompletionScreen extends StatelessWidget {
  const MediaCompletionScreen({
    super.key,
    required this.mediaState,
  });

  final MediaPrintingState mediaState;

  @override
  Widget build(BuildContext context) {
    return OrderCompletionScreen(
      orderType: OrderType.media,
      summerySheet: BlocBuilder<OrderCompletionCubit, OrderCompletionState>(
          buildWhen: (previous, current) =>
              previous.deliveryType != current.deliveryType,
          builder: (context, state) {
            final tax =
                (locator<SharedData>().tax! / 100) * mediaState.totalPrice;
            final totalPriceAfterTax = mediaState.totalPrice + tax;
            final shippingCost = locator<SharedData>().shippingCost!;
            return PriceSummeryBottomSheet(
              onTap: () {
                context
                    .read<OrderCompletionCubit>()
                    .makeMediaOrder(mediaState.forms);
              },
              totalValue: state.deliveryType == DeliveryType.home
                  ? totalPriceAfterTax + shippingCost
                  : totalPriceAfterTax,
              content: MediaPrintingSummery(
                forms: mediaState.forms,
                tax: tax,
                shippingCost: shippingCost,
                showShippingCost: state.deliveryType == DeliveryType.home,
              ),
            );
          }),
    );
  }
}
