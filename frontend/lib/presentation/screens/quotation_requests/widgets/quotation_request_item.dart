import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../data/models/quotation_request_model.dart';
import '../../../widgets/row_item.dart';

import '../../../widgets/custom_shadow_container.dart';

class QuotationRequestItem extends StatelessWidget {
  final QuotationRequestModel quotationRequest;

  const QuotationRequestItem({
    super.key,
    required this.quotationRequest,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.pushNamed(context, AppRoutes.quotaionRequestDetails,
            arguments: quotationRequest.id);
      },
      child: CustomShadowContainer(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        child: Column(
          children: [
            RowItem(
              title: AppStrings.userName.tr(),
              content: quotationRequest.userName,
            ),
            SizedBox(
              height: 10.h,
            ),
            RowItem(
              title: AppStrings.email.tr(),
              content: quotationRequest.email,
            ),
            SizedBox(
              height: 10.h,
            ),
            RowItem(
              title: AppStrings.status.tr(),
              content: quotationRequest.status,
            ),
          ],
        ),
      ),
    );
  }
}
