import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/cubit/paper_printing/paper_printing_cubit.dart';
import 'package:ibn_sina/cubit/order_completion/order_completion_cubit.dart';
import 'package:ibn_sina/presentation/bottom_sheets/price_summery_bottom_sheet.dart';
import 'package:ibn_sina/presentation/screens/order_completion/order_completion_screen.dart';
import 'package:ibn_sina/presentation/screens/order_completion/widgets/paper_printing_summery.dart';

class PaperCompletionScreen extends StatelessWidget {
  const PaperCompletionScreen({
    super.key,
    required this.paperState,
  });

  final PaperPrintingState paperState;

  @override
  Widget build(BuildContext context) {
    return OrderCompletionScreen(
      orderType: OrderType.paper,
      summerySheet: BlocBuilder<OrderCompletionCubit, OrderCompletionState>(
          buildWhen: (previous, current) =>
              previous.deliveryType != current.deliveryType,
          builder: (context, state) {
            final totalPrice = paperState.totalPrice + paperState.optionsPrice;
            final tax = (locator<SharedData>().tax! / 100) * totalPrice;
            final totalPriceAfterTax = totalPrice + tax;
            final shippingCost = locator<SharedData>().shippingCost!;
            return PriceSummeryBottomSheet(
              onTap: () {
                context.read<OrderCompletionCubit>().makePaperOrder(paperState);
              },
              totalValue: state.deliveryType == DeliveryType.home
                  ? totalPriceAfterTax + shippingCost
                  : totalPriceAfterTax,
              content: PaperPrintingSummery(
                printingColor: paperState.printingColor!,
                pageCount: paperState.pageCount,
                copiesCount: paperState.copiesCount,
                options: paperState.options,
                tax: tax,
                shippingCost: shippingCost,
                showShippingCost: state.deliveryType == DeliveryType.home,
              ),
            );
          }),
    );
  }
}
