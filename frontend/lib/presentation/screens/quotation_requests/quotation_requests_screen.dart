import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../cubit/quotation_request/quotation_request_cubit.dart';
import 'widgets/quotation_request_item.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/no_data.dart';

class QuotationRequestsScreen extends StatelessWidget {
  const QuotationRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.quotationRequests.tr(),
        leading: const CustomBackButton(),
      ),
      body: BlocBuilder<QuotationRequestCubit, QuotationRequestState>(
        builder: (context, state) {
          if (state is QuotationRequestLoading) {
            return const FetchLoading();
          } else if (state is QuotationRequestError) {
            return ErrorData(
              onTap: () {
                context.read<QuotationRequestCubit>().getQuotationRequests();
              },
              message: state.message,
            );
          } else if (state is QuotationRequestsLoaded) {
            return state.quotationRequests.isEmpty
                ? Center(
                    child: NoData(
                      title: AppStrings.noData.tr(),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<QuotationRequestCubit>()
                          .getQuotationRequests();
                    },
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.horizontalPadding.w,
                        vertical: AppSizes.verticalPadding.h,
                      ),
                      itemBuilder: (context, index) {
                        final quotationRequest = state.quotationRequests[index];
                        return QuotationRequestItem(
                          quotationRequest: quotationRequest,
                        );
                      },
                      separatorBuilder: (_, __) {
                        return SizedBox(
                          height: 12.h,
                        );
                      },
                      itemCount: state.quotationRequests.length,
                    ),
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
