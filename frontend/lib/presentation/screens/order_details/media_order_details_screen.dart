import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/locale/language_manager.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/cubit/order_details/order_details_cubit.dart';
import 'package:ibn_sina/presentation/bottom_sheets/payment_summary_bottom_sheet.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/media_order_summery_details_widget.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/city_details_widget.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/payment_status_alert.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/pdf/invoice_pdf_widget.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/pdf/invoices_pdf.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/policy_widget.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';
import 'package:ibn_sina/presentation/widgets/error_widget.dart';
import '../../../core/utils/app_strings.dart';
import '../../widgets/custom_back_button.dart';
import '../our_branches/widgets/branch_item_widget.dart';

class MediaOrderDetailsScreen extends StatelessWidget {
  const MediaOrderDetailsScreen({super.key});

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
                context.read<OrderDetailsCubit>().getMediaOrderDetails();
              },
              message: state.message,
            );
          } else if (state is OrderDetailsLoaded) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding.w,
                    vertical: AppSizes.verticalPadding.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaymentStatusAlert(
                        paymentStatus: state.mediaOrder!.paymentStatus,
                        invoiceUrl: state.mediaOrder!.invoiceUrl,
                        orderType: OrderType.media,
                        routeName: AppRoutes.mediaOrderDetails,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      if (state.mediaOrder!.items.isNotEmpty) ...[
                        MediaOrderSummeryDetailsWidget(
                          mediaItems: state.mediaOrder!.items,
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                      if (state.mediaOrder!.branch != null) ...[
                        Text(
                          state.mediaOrder!.orderStatus.contains('done')
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
                          branchModel: state.mediaOrder!.branch!,
                        ),
                      ] else
                        Column(
                          children: [
                            CityDetailsWidget(
                              city: state.mediaOrder!.city!,
                              lat: state.mediaOrder!.latitude,
                              lng: state.mediaOrder!.longitude,
                              address: state.mediaOrder!.address,
                              buildingNumber: state.mediaOrder!.buildingNumber,
                              apartmentNumber:
                                  state.mediaOrder!.apartmentNumber,
                              floorNumber: state.mediaOrder!.floorNumber,
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            PolicyWidget(
                              policyNumber: state.mediaOrder!.policyNumber,
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 18.h,
                      ),
                      InvoicePdfWidget(
                        builder: ((logobytes) {
                          return mediaInvoice(
                            isEnglish: LanguageManager.isEnglish(context),
                            mediaOrder: state.mediaOrder!,
                            logobytes: logobytes,
                          );
                        }),
                        fileName:
                            'media_order_${state.mediaOrder!.id}${LanguageManager.getCurrentLanguageCode(context)}.pdf',
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      PaymentSummaryBottomSheet(
                        orderValue: state.mediaOrder!.prices.subTotal,
                        addedValue: state.mediaOrder!.prices.vat,
                        discountValue: state.mediaOrder!.prices.coupon,
                        shippingCost: state.mediaOrder!.prices.deliveryTax,
                        totalValue: state.mediaOrder!.prices.total,
                        readOnly: true,
                        deliveryType: state.mediaOrder!.deliveryType,
                        orderType: OrderType.media,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
