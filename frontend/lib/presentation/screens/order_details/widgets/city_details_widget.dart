import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/data/models/city_model.dart';
import 'package:ibn_sina/presentation/widgets/custom_shadow_container.dart';
import 'package:ibn_sina/presentation/widgets/row_item.dart';
import 'package:ibn_sina/presentation/widgets/titled_widget.dart';

class CityDetailsWidget extends StatelessWidget {
  const CityDetailsWidget({
    super.key,
    required this.city,
    required this.lat,
    required this.lng,
    required this.address,
    required this.buildingNumber,
    required this.apartmentNumber,
    required this.floorNumber,
  });

  final CityModel city;
  final double lat;
  final double lng;
  final String address;
  final String buildingNumber;
  final String apartmentNumber;
  final String floorNumber;

  @override
  Widget build(BuildContext context) {
    return TitledWidget(
      title: AppStrings.addressDetails.tr(),
      child: CustomShadowContainer(
        padding: EdgeInsets.symmetric(
          horizontal: 7.w,
          vertical: 12.h,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: RowItem(
                    title: AppStrings.city.tr(),
                    content: city.name,
                  ),
                ),
                InkWell(
                  onTap: () {
                    HelperFunctions.openGoogleMap(
                      context,
                      lat,
                      lng,
                    );
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                    child: SvgPicture.asset(
                      SvgImages.location,
                      width: 16.w,
                      height: 16.w,
                    ),
                  ),
                )
              ],
            ),
            const Divider(),
            RowItem(
              title: AppStrings.address.tr(),
              content: address,
            ),
            const Divider(),
            RowItem(
              title: AppStrings.buildingNumber.tr(),
              content: buildingNumber,
            ),
            const Divider(),
            RowItem(
              title: AppStrings.apartmentNumber.tr(),
              content: apartmentNumber,
            ),
            const Divider(),
            RowItem(
              title: AppStrings.floorNumber.tr(),
              content: floorNumber,
            ),
          ],
        ),
      ),
    );
  }
}
