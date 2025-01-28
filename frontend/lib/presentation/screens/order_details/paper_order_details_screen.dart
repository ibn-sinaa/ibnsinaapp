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
import 'package:ibn_sina/presentation/screens/order_details/widgets/city_details_widget.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/paper_info_details_widget.dart';
import 'package:ibn_sina/presentation/screens/order_details/widgets/paper_order_summery_details_widget.dart';
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

class PaperOrderDetailsScreen extends StatelessWidget {
  const PaperOrderDetailsScreen({super.key});

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
                context.read<OrderDetailsCubit>().getPaperOrderDetails();
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
                        paymentStatus: state.paperOrder!.paymentStatus,
                        invoiceUrl: state.paperOrder!.invoiceUrl,
                        orderType: OrderType.paper,
                        routeName: AppRoutes.paperOrderDetails,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      PaperInfoDetailsWidget(
                        copiesCount: state.paperOrder!.copyNumbers,
                        pageCount: state.paperOrder!.pageNumbers,
                        paperColor: state.paperOrder!.paperColor,
                        deliveryType: state.paperOrder!.deliveryType,
                        fileUploaded: state.paperOrder!.fileUploaded,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      if (state.paperOrder!.items.isNotEmpty) ...[
                        PaperOrderSummeryDetailsWidget(
                          paperItems: state.paperOrder!.items,
                          paperColor: state.paperOrder!.paperColor,
                          pageCount: state.paperOrder!.pageNumbers,
                          copiesCount: state.paperOrder!.copyNumbers,
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                      if (state.paperOrder!.branch != null) ...[
                        Text(
                          state.paperOrder!.orderStatus.contains('done')
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
                          branchModel: state.paperOrder!.branch!,
                        ),
                      ] else
                        Column(
                          children: [
                            CityDetailsWidget(
                              city: state.paperOrder!.city!,
                              lat: state.paperOrder!.latitude,
                              lng: state.paperOrder!.longitude,
                              address: state.paperOrder!.address,
                              buildingNumber: state.paperOrder!.buildingNumber,
                              apartmentNumber:
                                  state.paperOrder!.apartmentNumber,
                              floorNumber: state.paperOrder!.floorNumber,
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            PolicyWidget(
                              policyNumber: state.paperOrder!.policyNumber,
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 18.h,
                      ),
                      InvoicePdfWidget(
                        builder: ((logobytes) {
                          return paperInvoice(
                            isEnglish: LanguageManager.isEnglish(context),
                            paperOrder: state.paperOrder!,
                            logobytes: logobytes,
                          );
                        }),
                        fileName:
                            'paper_order_${state.paperOrder!.id}(${LanguageManager.getCurrentLanguageCode(context)}).pdf',
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      PaymentSummaryBottomSheet(
                        orderValue: state.paperOrder!.prices.subTotal,
                        addedValue: state.paperOrder!.prices.vat,
                        discountValue: state.paperOrder!.prices.coupon,
                        shippingCost: state.paperOrder!.prices.deliveryTax,
                        totalValue: state.paperOrder!.prices.total,
                        readOnly: true,
                        deliveryType: state.paperOrder!.deliveryType,
                        orderType: OrderType.paper,
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
