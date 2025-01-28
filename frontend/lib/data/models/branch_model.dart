import 'package:ibn_sina/data/models/city_model.dart';

class BranchModel {
  final int id;
  final String name;
  final String addressName;
  final String phone;
  final double lat;
  final double lng;
  final CityModel city;

  const BranchModel({
    required this.id,
    required this.name,
    required this.addressName,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.city,
  });

  factory BranchModel.fromMap(Map<String, dynamic> map) {
    return BranchModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      addressName: map['address_name'] ?? '',
      phone: map['phone'] ?? '',
      lat: double.tryParse(map['lat']) ?? 0,
      lng: double.tryParse(map['lng']) ?? 0,
      city: CityModel.fromMap(map['city'][0]),
    );
  }
}
