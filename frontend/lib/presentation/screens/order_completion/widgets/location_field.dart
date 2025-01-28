import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/data/models/city_model.dart';
import 'package:ibn_sina/data/models/location_model.dart';
import 'package:ibn_sina/presentation/screens/order_completion/widgets/cities_dropdown.dart';

class LocationField extends StatefulWidget {
  final void Function(LocationModel location) onLocationUpdated;
  final CityModel? selectedCity;
  final void Function(CityModel?)? onChanged;
  final LocationModel location;

  const LocationField({
    super.key,
    required this.onLocationUpdated,
    this.selectedCity,
    this.onChanged,
    required this.location,
  });

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  String _address = AppStrings.theLocation.tr();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.pleaseSelectTheLocationToBeDeliveredTo.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        CitiesDropdown(
          selectedCity: widget.selectedCity,
          onChanged: widget.onChanged,
        ),
        SizedBox(
          height: 24.h,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  AppRouter.pushNamed(
                    context,
                    AppRoutes.map,
                    arguments: widget.location,
                  ).then((location) {
                    if ((location as LocationModel?) != null) {
                      widget.onLocationUpdated(location as LocationModel);
                      _address = location.address!;
                    } else {
                      location?.address = null;
                      location?.latLng = null;
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                    start: 12.w,
                    end: 2.w,
                    top: 14.h,
                    bottom: 14.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.c707070,
                      width: AppSizes.borderWidth.w,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radius.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _address,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.c2D2F3A,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: Icon(
                          Icons.location_on,
                          size: 26.w,
                          color: AppColors.c707070,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
