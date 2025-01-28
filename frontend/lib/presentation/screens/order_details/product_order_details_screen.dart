import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/locale/language_manager.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/cubit/order_details/order_details_cubit.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/city_details_widget.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/payment_status_alert.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/pdf/invoice_pdf_widget.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/pdf/invoices_pdf.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/policy_widget.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_shadow_container.dart';

import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../bottom_sheets/payment_summary_bottom_sheet.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/error_widget.dart';
import 'widgets/product_order_details_widget.dart';
import '../our_branches/widgets/branch_item_widget.dart';

class ProductOrderDetailsScreen extends StatefulWidget {
  const ProductOrderDetailsScreen({super.key});

  @override
  State<ProductOrderDetailsScreen> createState() =>
      _ProductOrderDetailsScreenState();
}

class _ProductOrderDetailsScreenState extends State<ProductOrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.orderDetails.tr(),
        leading: const CustomBackButton(),
      ),
      body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return const FetchLoading();
          } else if (state is OrderDetailsError) {
            return ErrorData(
              onTap: () {
                context.read<OrderDetailsCubit>().getProductOrderDetails();
              },
              message: state.message,
            );
          } else if (state is OrderDetailsLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding.w,
                vertical: AppSizes.verticalPadding.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PaymentStatusAlert(
                    paymentStatus: state.productOrder!.paymentStatus,
                    invoiceUrl: state.productOrder!.invoiceUrl,
                    orderType: OrderType.media,
                    routeName: AppRoutes.productOrderDetails,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ProductOrderDetailsWidget(
                        orderItem: state.productOrder!.items[index],
                      );
                    },
                    separatorBuilder: (_, __) {
                      return SizedBox(
                        height: 12.h,
                      );
                    },
                    itemCount: state.productOrder!.items.length,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  if (state.productOrder!.branch != null) ...[
                    Text(
                      state.productOrder!.orderStatus.contains('done')
                          ? AppStrings.theBranchFromWhichItWasReceived.tr()
                          : AppStrings.theBranchIsToBeReceivedFrom.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    BranchItemWidget(
                      branchModel: state.productOrder!.branch!,
                    ),
                  ] else
                    Column(
                      children: [
                        CityDetailsWidget(
                          city: state.productOrder!.city!,
                          lat: state.productOrder!.latitude,
                          lng: state.productOrder!.longitude,
                          address: state.productOrder!.address,
                          buildingNumber: state.productOrder!.buildingNumber,
                          apartmentNumber: state.productOrder!.apartmentNumber,
                          floorNumber: state.productOrder!.floorNumber,
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        PolicyWidget(
                          policyNumber: state.productOrder!.policyNumber,
                        ),
                      ],
                    ),
                  if (state.productOrder!.note.isNotEmpty) ...[
                    SizedBox(
                      height: 18.h,
                    ),
                    Text(
                      AppStrings.notes.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomShadowContainer(
                      child: Text(
                        state.productOrder!.note,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.c989898,
                        ),
                      ),
                    )
                  ],
                  SizedBox(
                    height: 18.h,
                  ),
                  InvoicePdfWidget(
                    builder: ((logobytes) {
                      return productInvoice(
                        isEnglish: LanguageManager.isEnglish(context),
                        productOrder: state.productOrder!,
                        logobytes: logobytes,
                      );
                    }),
                    fileName:
                        'product_order_${state.productOrder!.id}(${LanguageManager.getCurrentLanguageCode(context)}).pdf',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  PaymentSummaryBottomSheet(
                    orderValue: state.productOrder!.prices.subTotal,
                    addedValue: state.productOrder!.prices.vat,
                    discountValue: state.productOrder!.prices.coupon,
                    shippingCost: state.productOrder!.prices.deliveryTax,
                    totalValue: state.productOrder!.prices.total,
                    readOnly: true,
                    deliveryType: state.productOrder!.deliveryType,
                    orderType: OrderType.product,
                  )
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
