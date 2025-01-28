
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/presentation/widgets/custom_shadow_container.dart';
import 'package:ibn_sina/presentation/widgets/row_item.dart';
import 'package:ibn_sina/presentation/widgets/titled_widget.dart';

class PolicyWidget extends StatelessWidget {
  const PolicyWidget({super.key, required this.policyNumber});

  final String policyNumber;

  @override
  Widget build(BuildContext context) {
    return TitledWidget(
      title: AppStrings.policyDetails.tr(),
      child: CustomShadowContainer(
        child: Column(
          children: [
            RowItem(
              title: AppStrings.policyNumber.tr(),
              content: policyNumber,
            ),
            const Divider(),
            RowItem(
              title: AppStrings.policyFile.tr(),
              customContent: Expanded(
                child: Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        HelperFunctions.launchWebUrl(
                          context,
                          'https://www.aramex.com/track/results?ShipmentNumber=$policyNumber',
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: AppSizes.borderWidth.r,
                          ),
                        ),
                        child: Text(
                          AppStrings.tracking.tr(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              crossAxisAlignment: CrossAxisAlignment.center,
            )
          ],
        ),
      ),
    );
  }
}
