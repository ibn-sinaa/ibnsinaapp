import 'package:easy_localization/easy_localization.dart' as lag;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/data/models/branch_model.dart';
import 'package:ibn_sina/data/models/city_model.dart';
import 'package:ibn_sina/data/models/location_model.dart';
import 'package:ibn_sina/presentation/screens/order_completion/widgets/branches_dropdown.dart';
import 'package:ibn_sina/presentation/screens/order_completion/widgets/location_field.dart';
import '../../../../config/locale/language_manager.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../widgets/custom_radio_tile.dart';

class DeliveryTypeWidget extends StatelessWidget {
  final DeliveryType deliveryType;
  final dynamic Function(DeliveryType deliveryType) onChanged;
  final BranchModel? branch;
  final void Function(BranchModel?)? onBranchChanged;
  final CityModel? city;
  final void Function(CityModel?)? onCityChanged;
  final void Function(LocationModel location) onLocationUpdated;
  final LocationModel location;

  const DeliveryTypeWidget({
    super.key,
    required this.deliveryType,
    required this.onChanged,
    this.branch,
    this.onBranchChanged,
    this.city,
    this.onCityChanged,
    required this.onLocationUpdated,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.chooseTheMethodOfDelivery.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            Directionality(
              textDirection: LanguageManager.isEnglish(context)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: CustomRadioTile<DeliveryType>(
                onChanged: onChanged,
                value: DeliveryType.branch,
                groupValue: deliveryType,
                title: DeliveryType.branch.title.tr(),
              ),
            ),
            SizedBox(
              width: 24.w,
            ),
            Directionality(
              textDirection: LanguageManager.isEnglish(context)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: CustomRadioTile<DeliveryType>(
                onChanged: onChanged,
                value: DeliveryType.home,
                groupValue: deliveryType,
                title: DeliveryType.home.title.tr(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeInCubic,
          switchOutCurve: Curves.easeInCubic,
          child: deliveryType == DeliveryType.branch
              ? BranchesDropdown(
                  selectedBranch: branch,
                  onChanged: onBranchChanged,
                )
              : LocationField(
                  onLocationUpdated: onLocationUpdated,
                  selectedCity: city,
                  onChanged: onCityChanged,
                  location: location,
                ),
        ),
      ],
    );
  }
}
