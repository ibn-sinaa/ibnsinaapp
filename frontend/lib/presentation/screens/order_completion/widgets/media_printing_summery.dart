import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/data/models/media_form_model.dart';
import 'package:ibn_sina/presentation/widgets/row_item1.dart';

class MediaPrintingSummery extends StatelessWidget {
  const MediaPrintingSummery({
    super.key,
    required this.forms,
    required this.tax,
    required this.shippingCost,
    required this.showShippingCost,
  });

  final List<MediaFormModel> forms;
  final num tax;
  final num shippingCost;
  final bool showShippingCost;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.paymentSummary.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 9.h),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _ItemForm(form: forms[index]);
          },
          separatorBuilder: (_, __) {
            return Divider(height: 24.h);
          },
          itemCount: forms.length,
        ),
        Divider(height: 24.h),
        if (showShippingCost) ...[
          SizedBox(
            height: 9.h,
          ),
          RowItem1(
            title: AppStrings.shippingCost.tr(),
            content: HelperFunctions.getPrice(shippingCost),
          ),
        ],
        SizedBox(
          height: 9.h,
        ),
        RowItem1(
          title: AppStrings.addedValue.tr(),
          content: HelperFunctions.getPrice(tax),
        ),
      ],
    );
  }
}

class _ItemForm extends StatelessWidget {
  const _ItemForm({required this.form});

  final MediaFormModel form;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowItem1(
          title: AppStrings.materialType.tr(),
          subtitle: form.materialType!.name,
          content: HelperFunctions.getPrice(form.materialType!.price),
        ),
        SizedBox(
          height: 9.h,
        ),
        RowItem1(
          title: AppStrings.printingSize.tr(),
          content: HelperFunctions.handlePrintingSize(
            context,
            form.height,
            form.width,
          ),
          // enableContentLtr: true,
        ),
        SizedBox(
          height: 9.h,
        ),
        RowItem1(
          title: AppStrings.copiesCount.tr(),
          content: '${form.copiesCount}',
        ),
        SizedBox(
          height: 9.h,
        ),
        RowItem1(
          title: AppStrings.total.tr(),
          content: HelperFunctions.getPrice(form.copiesCount *
              form.height *
              form.width *
              form.materialType!.price),
        ),
      ],
    );
  }
}
