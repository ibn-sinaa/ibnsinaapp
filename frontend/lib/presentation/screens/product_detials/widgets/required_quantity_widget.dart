import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../cubit/order_flow/order_flow_cubit.dart';
import '../../../../data/models/amount/amount_model.dart';
import '../../../../data/models/cart/cart_model.dart';
import '../../../widgets/quantity_widget.dart';

class RequiredQuantityWidget extends StatelessWidget {
  final List<AmountModel> amounts;

  const RequiredQuantityWidget({
    super.key,
    required this.amounts,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStrings.requiredQuantity.tr(),
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const Spacer(),
        BlocBuilder<OrderFlowCubit, CartModel>(
          builder: (context, state) {
            return PopupMenuButton<AmountModel>(
              initialValue: state.amount,
              child: QuantityWidget(amount: state.amount.key),
              itemBuilder: (context) {
                return amounts
                    .map(
                      (amount) => PopupMenuItem<AmountModel>(
                        height: 50.h,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check,
                              size: 16.w,
                              color: state.amount == amount
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.transparent,
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text(
                              amount.key.toString(),
                              style: TextStyle(
                                color: state.amount == amount
                                    ? Theme.of(context).primaryColor
                                    : AppColors.c2D2F3A,
                                fontSize: 14.sp,
                                height: 1.5,
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          context.read<OrderFlowCubit>().changeAmount(amount);
                        },
                      ),
                    )
                    .toList();
              },
            );
          },
        )
      ],
    );
  }
}
