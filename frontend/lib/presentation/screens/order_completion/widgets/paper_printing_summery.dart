import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';
import 'package:ibn_sina/data/models/option_model/option_model.dart';
import 'package:ibn_sina/presentation/widgets/row_item1.dart';

class PaperPrintingSummery extends StatelessWidget {
  const PaperPrintingSummery({
    super.key,
    required this.printingColor,
    required this.pageCount,
    required this.copiesCount,
    required this.options,
    required this.tax,
    required this.shippingCost,
    required this.showShippingCost,
  });

  final OptionDataModel printingColor;
  final int pageCount;
  final int copiesCount;
  final List<OptionModel> options;
  final num tax;
  final num shippingCost;
  final bool showShippingCost;

  @override
  Widget build(BuildContext context) {
    final selectedOptions = _getSelectedOptions();

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
        SizedBox(
          height: 22.h,
        ),
        RowItem1(
          title: AppStrings.pageCount.tr(),
          content: pageCount.toString(),
        ),
        SizedBox(
          height: 9.h,
        ),
        RowItem1(
          title: AppStrings.copiesCount.tr(),
          content: copiesCount.toString(),
        ),
        SizedBox(
          height: 9.h,
        ),
        RowItem1(
          title: AppStrings.printingColor.tr(),
          subtitle: printingColor.name,
          content: HelperFunctions.getPrice(
              copiesCount * pageCount * printingColor.price),
        ),
        SizedBox(
          height: 9.h,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final option = selectedOptions[index];
            return Column(
              children: option.data
                  .map((optionData) => Padding(
                        padding: EdgeInsets.only(bottom: 9.h),
                        child: RowItem1(
                          title: option.name,
                          subtitle: optionData.name,
                          content:
                              HelperFunctions.getPrice(optionData.totalPrice),
                        ),
                      ))
                  .toList(),
            );
          },
          itemCount: selectedOptions.length,
        ),
        if (showShippingCost) ...[
          RowItem1(
            title: AppStrings.shippingCost.tr(),
            content: HelperFunctions.getPrice(shippingCost),
          ),
          SizedBox(
            height: 9.h,
          ),
        ],
        RowItem1(
          title: AppStrings.addedValue.tr(),
          content: HelperFunctions.getPrice(tax),
        ),
      ],
    );
  }

  List<OptionModel> _getSelectedOptions() {
    final selectedOptions = <OptionModel>[];
    for (var option in options) {
      final selectedOptionsData =
          option.data.where((optionData) => optionData.isSelected).toList();
      if (selectedOptionsData.isNotEmpty) {
        selectedOptions
            .add(OptionModel.fromOption(option, selectedOptionsData));
      }
    }
    return selectedOptions;
  }
}
