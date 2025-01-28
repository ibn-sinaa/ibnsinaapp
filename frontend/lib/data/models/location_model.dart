import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  String? address;
  String? buildingNumber;
  String? apartmentNumber;
  String? floorNumber;
  LatLng? latLng;

  LocationModel({
    this.address,
    this.buildingNumber,
    this.apartmentNumber,
    this.floorNumber,
    this.latLng,
  });

  factory LocationModel.fromLocation(LocationModel location) {
    return LocationModel(
      address: location.address,
      buildingNumber: location.buildingNumber,
      apartmentNumber: location.apartmentNumber,
      floorNumber: location.floorNumber,
      latLng: location.latLng,
    );
  }

  bool isLocationSelected() => latLng != null && address != null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'buildingNumber': buildingNumber,
      'apartmentNumber': apartmentNumber,
      'floorNumber': floorNumber,
      'lat': latLng!.latitude,
      'lon': latLng!.longitude,
    };
  }
}
