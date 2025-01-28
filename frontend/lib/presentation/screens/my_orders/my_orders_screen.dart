import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/cubit/main/main_cubit.dart';
import 'package:ibn_sina/presentation/screens/my_orders/widgets/media_order_widget.dart';
import 'package:ibn_sina/presentation/screens/my_orders/widgets/paper_order_widget.dart';
import 'package:ibn_sina/presentation/screens/my_orders/widgets/product_order_widget.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/enums.dart';
import '../../../cubit/my_orders/my_orders_cubit.dart';
import '../../../cubit/refresh/refresh_cubit.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/no_data.dart';
import 'widgets/my_orders_tap.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({
    super.key,
    required this.orderType,
  });

  final OrderType orderType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefreshCubit, bool>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            customTitle: orderType.isProduct()
                ? Text(orderType.title.tr())
                : Text(orderType.title.tr()),
            leading: CustomBackButton(
              onTap: () {
                switch (orderType) {
                  case OrderType.product:
                    context.read<MainCubit>().goToScreenWithIndex(0);
                  case OrderType.paper:
                  case OrderType.media:
                    AppRouter.pop(context);
                }
              },
            ),
          ),
          body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppSizes.verticalPadding.h,
                      left: AppSizes.horizontalPadding.w,
                      right: AppSizes.horizontalPadding.w,
                    ),
                    child: Row(
                      children: [
                        MyOrdersTap(
                          selectedTapId: state.tapId,
                          tapId: 0,
                          title: AppStrings.currentOrders.tr(),
                          orderType: orderType,
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        MyOrdersTap(
                          selectedTapId: state.tapId,
                          tapId: 1,
                          title: AppStrings.previousOrders.tr(),
                          orderType: orderType,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (state.requestState == RequestState.loading) {
                          return const FetchLoading();
                        } else if (state.requestState == RequestState.error) {
                          return ErrorData(
                            onTap: () => _getMyOrders(context),
                            message: state.message,
                          );
                        } else if (state.requestState == RequestState.loaded) {
                          final length = _getMyOrdersLength(state);
                          return length == 0
                              ? NoData(
                                  title: AppStrings.noOrders.tr(),
                                )
                              : NotificationListener<UserScrollNotification>(
                                  onNotification: (notification) {
                                    if (notification.metrics.pixels >=
                                        notification.metrics.maxScrollExtent) {
                                      _getMyOrders(context);
                                    }
                                    return true;
                                  },
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      _getMyOrders(context, true);
                                    },
                                    child: ListView.separated(
                                      padding: EdgeInsets.only(
                                        top: 12.h,
                                        bottom: AppSizes.verticalPadding.h,
                                        left: AppSizes.horizontalPadding.w,
                                        right: AppSizes.horizontalPadding.w,
                                      ),
                                      itemBuilder: (context, index) {
                                        if (index == length) {
                                          return state.moreState ==
                                                  RequestState.loading
                                              ? const InlineLoading()
                                              : const SizedBox.shrink();
                                        }

                                        return _getMyOrderItem(state, index);
                                      },
                                      separatorBuilder: (_, __) {
                                        return SizedBox(
                                          height: 12.h,
                                        );
                                      },
                                      itemCount: length + 1,
                                    ),
                                  ),
                                );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          floatingActionButton: orderType.isProduct()
              ? null
              : SizedBox(
                  width:
                      getValueForScreenType(context, medium: 50, large: 60).r,
                  height:
                      getValueForScreenType(context, medium: 50, large: 60).r,
                  child: FloatingActionButton(
                    onPressed: () {
                      locator<SharedData>().isPaymentScreenOpened = false;
                      AppRouter.pushNamed(
                        context,
                        orderType.isPaper()
                            ? AppRoutes.paperPrinting
                            : AppRoutes.mediaPrinting,
                      ).then((_) {
                        if (locator<SharedData>().isPaymentScreenOpened) {
                          _getMyOrders(context, true);
                        }
                      });
                    },
                    child: Icon(
                      Icons.add,
                      size: 26.w,
                    ),
                  ),
                ),
        );
      },
    );
  }

  void _getMyOrders(BuildContext context, [bool refresh = false]) {
    switch (orderType) {
      case OrderType.product:
        context.read<MyOrdersCubit>().getProductOrders(refresh: refresh);
      case OrderType.paper:
        context.read<MyOrdersCubit>().getPaperOrders(refresh: refresh);
      case OrderType.media:
        context.read<MyOrdersCubit>().getMediaOrders(refresh: refresh);
        break;
    }
  }

  int _getMyOrdersLength(MyOrdersState state) {
    switch (orderType) {
      case OrderType.product:
        return state.productOrders.length;
      case OrderType.paper:
        return state.paperOrders.length;
      case OrderType.media:
        return state.mediaOrders.length;
    }
  }

  Widget _getMyOrderItem(MyOrdersState state, int index) {
    switch (orderType) {
      case OrderType.product:
        return ProductOrderWidget(
          productOrder: state.productOrders[index],
        );
      case OrderType.paper:
        return PaperOrderWidget(
          paperOrder: state.paperOrders[index],
        );
      case OrderType.media:
        return MediaOrderWidget(
          mediaOrder: state.mediaOrders[index],
        );
    }
  }
}
