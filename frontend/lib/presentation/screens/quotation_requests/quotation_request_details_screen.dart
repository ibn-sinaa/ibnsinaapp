import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/row_item.dart';

import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../cubit/quotation_request/quotation_request_cubit.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/downloading_file_widget.dart';
import '../../widgets/error_widget.dart';
import 'widgets/quotation_details_item.dart';

class QuotationRequestDetailsScreen extends StatefulWidget {
  const QuotationRequestDetailsScreen({super.key});

  @override
  State<QuotationRequestDetailsScreen> createState() =>
      _QuotationRequestDetailsScreenState();
}

class _QuotationRequestDetailsScreenState
    extends State<QuotationRequestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.quotationRequestDetails.tr(),
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: AppSizes.verticalPadding.h,
        ),
        child: BlocBuilder<QuotationRequestCubit, QuotationRequestState>(
          builder: (context, state) {
            if (state is QuotationRequestLoading) {
              return const FetchLoading();
            } else if (state is QuotationRequestError) {
              return ErrorData(
                onTap: () {
                  context
                      .read<QuotationRequestCubit>()
                      .getQuotationRequestDetails();
                },
                message: state.message,
              );
            } else if (state is QuotationRequestDetailsLoaded) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.horizontalPadding.w,
                      vertical: AppSizes.verticalPadding.h,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          QuotationDetailsItem(
                            title: AppStrings.userName.tr(),
                            content: state.quotationRequest.userName,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          QuotationDetailsItem(
                            title: AppStrings.email.tr(),
                            content: state.quotationRequest.email,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          QuotationDetailsItem(
                            title: AppStrings.phoneNumber.tr(),
                            content: state.quotationRequest.phone,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          QuotationDetailsItem(
                            title: AppStrings.messageContent.tr(),
                            content: state.quotationRequest.message,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          QuotationDetailsItem(
                            title: AppStrings.status.tr(),
                            content: state.quotationRequest.status,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          QuotationDetailsItem(
                            title: AppStrings.price.tr(),
                            content: state.quotationRequest.price > 0
                                ? '${state.quotationRequest.price.toString()} ${AppStrings.sar.tr()}'
                                : AppStrings.pricingIsNotDoneYet.tr(),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          QuotationDetailsItem(
                            title: AppStrings.adminNotes.tr(),
                            content: state.quotationRequest.notes == '0' ||
                                    state.quotationRequest.notes.isEmpty
                                ? AppStrings.waitingForReply.tr()
                                : state.quotationRequest.notes,
                          ),
                          if (state.quotationRequest.image.isNotEmpty) ...[
                            SizedBox(
                              height: 24.h,
                            ),
                            RowItem(
                              title: AppStrings.designFile.tr(),
                              customContent: Expanded(
                                child: DownloadingFileWidget(
                                  fileUrl: state.quotationRequest.image,
                                ),
                              ),
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     Expanded(
                            //       child: QuotationDetailsItem(
                            //         title: AppStrings.designFile.tr(),
                            //         content: state.quotationRequest.image,
                            //         isLink: true,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 24.w,
                            //     ),

                            //     Material(
                            //       child: IconButton(
                            //         onPressed: () {
                            //           if (_startDonwloading == false) {
                            //             setState(() {
                            //               _startDonwloading = true;
                            //             });
                            //           }
                            //         },
                            //         icon: Icon(
                            //           Icons.download,
                            //           size: 24.w,
                            //           color: Theme.of(context)
                            //               .colorScheme
                            //               .secondary,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
