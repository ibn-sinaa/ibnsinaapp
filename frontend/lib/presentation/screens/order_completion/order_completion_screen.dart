import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/cubit/cart/cart_cubit.dart';
import 'package:ibn_sina/cubit/hide_bottom_sheet/hide_bottom_sheet_cubit.dart';
import 'package:ibn_sina/cubit/order_completion/order_completion_cubit.dart';
import 'package:ibn_sina/data/repositories/app_repository.dart';
import 'package:ibn_sina/data/repositories/orders_repository.dart';
import 'package:ibn_sina/data/repositories/user_repository.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_back_button.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';
import 'package:ibn_sina/presentation/widgets/error_widget.dart';
import 'package:ibn_sina/presentation/screens/order_completion/widgets/delivery_type_widget.dart';

class OrderCompletionScreen extends StatelessWidget {
  const OrderCompletionScreen({
    super.key,
    required this.summerySheet,
    required this.orderType,
  });

  final Widget summerySheet;
  final OrderType orderType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCompletionCubit(locator<AppRepository>(),
          locator<OrdersRepository>(), locator<UserRepository>())
        ..getAppSettings(),
      child: GestureDetector(
        onTap: context.read<HideBottomSheetCubit>().hide,
        child: Scaffold(
          appBar: CustomAppBar(
            title: AppStrings.orderCompletion.tr(),
            leading: const CustomBackButton(),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding.w,
                    vertical: AppSizes.verticalPadding.h,
                  ),
                  child: Column(
                    children: [
                      BlocConsumer<OrderCompletionCubit, OrderCompletionState>(
                        listener: _handleListener,
                        builder: (context, state) {
                          return DeliveryTypeWidget(
                            deliveryType: state.deliveryType,
                            branch: state.branch,
                            onChanged: context
                                .read<OrderCompletionCubit>()
                                .changeDeliveryType,
                            city: state.city,
                            onCityChanged:
                                context.read<OrderCompletionCubit>().updateCity,
                            onBranchChanged: context
                                .read<OrderCompletionCubit>()
                                .updateBranch,
                            onLocationUpdated: context
                                .read<OrderCompletionCubit>()
                                .onLocationUpdated,
                            location: state.location,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<OrderCompletionCubit, OrderCompletionState>(
                buildWhen: (previous, current) =>
                    previous.requestState != current.requestState,
                builder: (context, state) {
                  if (state.requestState == RequestState.loading) {
                    return Padding(
                      padding:
                          EdgeInsets.only(bottom: AppSizes.verticalPadding.h),
                      child: const FetchLoading(
                        size: 50,
                      ),
                    );
                  } else if (state.requestState == RequestState.error) {
                    return Padding(
                      padding:
                          EdgeInsets.only(bottom: AppSizes.verticalPadding.h),
                      child: ErrorData(
                        message: state.message,
                        onTap:
                            context.read<OrderCompletionCubit>().getAppSettings,
                      ),
                    );
                  } else if (state.requestState == RequestState.loaded) {
                    return summerySheet;
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleListener(BuildContext context, OrderCompletionState state) {
    HelperFunctions.submitActions(
      context,
      requestState: state.makeOrderState,
      onLoaded: () {
        HelperFunctions.showToastMessage(context, state.message);
        AppRouter.pop(context);
        if (orderType.isProduct()) {
          context.read<CartCubit>().clearCart();
        }
        AppRouter.pushNamed(
          context,
          AppRoutes.payment,
          arguments: {
            'url': state.invoiceUrl,
            'orderType': orderType,
          },
        );
      },
      onError: () {
        if (state.errorType == 1) {
          AppRouter.pop(context);
        }
        HelperFunctions.showToastMessage(context, state.message);
      },
      loadingMessage: AppStrings.pleaseWait.tr(),
      loadingSubmessage: AppStrings.thePaymentPageIsLoading.tr(),
    );
  }
}
