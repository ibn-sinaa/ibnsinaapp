import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/data/models/location_model.dart';
import 'package:ibn_sina/presentation/dialogs/location_information_dialog.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_back_button.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.location});
  final LocationModel location;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _controller = Completer<GoogleMapController>();

  LatLng? _latLng;
  var _isLoading = false;
  final _markers = <Marker>{};

  @override
  void initState() {
    super.initState();
    if (widget.location.isLocationSelected()) {
      _goToLocation(widget.location.latLng!);
    } else {
      _getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.locationSelection.tr(),
        leading: const CustomBackButton(),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _getCameraPosition(
              const LatLng(0, 0),
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            padding: EdgeInsets.only(
              left: 6.w,
              right: 6.w,
              top: AppSizes.verticalPadding.h,
            ),
            markers: _markers,
            onMapCreated: _controller.complete,
            onTap: (latLng) {
              setState(() {
                _latLng = latLng;
                _buildMarker(latLng);
              });
            },
          ),
          if (_isLoading == true)
            const FetchLoading()
          else
            Positioned(
              bottom: AppSizes.verticalPadding.h,
              left: 0,
              right: 0,
              child: Center(
                child: CustomButton(
                  onPressed: () {
                    HelperFunctions.showAppDialog<LocationModel?>(
                      context,
                      child: LocationInformationDialog(
                        location: widget.location,
                      ),
                    ).then((location) {
                      if (location != null) {
                        location.latLng = _latLng;
                        AppRouter.pop(context, location);
                      }
                    });
                  },
                  text: AppStrings.continue_.tr(),
                ),
              ),
            )
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });
    if (await HelperFunctions.hasLocationPermission()) {
      final location = await Geolocator.getCurrentPosition();
      _latLng = LatLng(location.latitude, location.longitude);
      _goToLocation(_latLng!);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _buildMarker(LatLng latLng) async {
    _markers
      ..clear()
      ..add(
        Marker(
          markerId: MarkerId(latLng.latitude.toString()),
          position: latLng,
        ),
      );
    widget.location.address = await _getAddressName(latLng);
  }

  CameraPosition _getCameraPosition(LatLng latLng) {
    return CameraPosition(
      target: latLng,
      zoom: 15,
    );
  }

  Future<void> _goToLocation(LatLng latLng) async {
    _buildMarker(latLng);
    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_getCameraPosition(latLng)),
    );
  }

  Future<String> _getAddressName(LatLng latLng) async {
    final placeMarker = (await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    ))
        .first;
    return '${placeMarker.locality} ${placeMarker.subAdministrativeArea} ${placeMarker.administrativeArea} ${placeMarker.country}';
  }
}
