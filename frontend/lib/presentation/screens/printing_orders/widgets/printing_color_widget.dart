import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';
import 'package:ibn_sina/presentation/widgets/custom_radio_tile.dart';

class PrintingColorwidget extends StatelessWidget {
  const PrintingColorwidget({
    super.key,
    required this.selectedPrintingColor,
    required this.printingColors,
    required this.onChanged,
  });

  final OptionDataModel selectedPrintingColor;
  final List<OptionDataModel> printingColors;
  final void Function(OptionDataModel printingColor) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.printingColor.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Row(
          children: printingColors
              .map(
                (printingColor) => Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: 32.w,
                  ),
                  child: CustomRadioTile<OptionDataModel>(
                    onChanged: (printingColor) {
                      onChanged(printingColor);
                    },
                    value: printingColor,
                    groupValue: selectedPrintingColor,
                    title: printingColor.name,
                    verticalPadding: 12,
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
