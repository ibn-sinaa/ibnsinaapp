import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../data/models/option_model/option_model.dart';

import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';

class ProductDetailsButton extends StatelessWidget {
  final List<OptionModel> options;

  const ProductDetailsButton({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.verticalPadding.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              onPressed: () {
                AppRouter.pushNamed(
                  context,
                  AppRoutes.yourOrderDetails,
                  arguments: options,
                );
              },
              text: AppStrings.continue_.tr().toUpperCase(),
            ),
          ),
          // SizedBox(
          //   width: 13.w,
          // ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 20.h),
          //   child: Text(
          //     AppStrings.sar.tr(),
          //     style: TextStyle(
          //       fontSize: 16.sp,
          //       color: Theme.of(context).colorScheme.secondary,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: 2.w,
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: 10.h),
          //   child: BlocBuilder<OrderFlowCubit, CartModel>(
          //     builder: (context, state) {
          //       return Text(
          //         state.totalPrice.toString(),
          //         style: TextStyle(
          //           fontSize: 29.sp,
          //           color: Theme.of(context).colorScheme.secondary,
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // SizedBox(
          //   width: 12.w,
          // )
        ],
      ),
    );
  }
}
