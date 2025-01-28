import 'dart:convert';

class MakePaperOrderParams {
  final int paperOrderColorId;
  final List<int> paperOptionData;
  final int copyNumbers;
  final int pageNumbers;
  final int userId;
  final String deliveryType;
  final int? branchId;
  final int? cityId;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? street;
  final String? floorNumber;
  final String? flatNumber;
  final String fileUploaded;

  MakePaperOrderParams({
    required this.paperOrderColorId,
    required this.paperOptionData,
    required this.copyNumbers,
    required this.pageNumbers,
    required this.userId,
    required this.deliveryType,
    required this.branchId,
    required this.cityId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.street,
    required this.floorNumber,
    required this.flatNumber,
    required this.fileUploaded,
  });

  Map<String, String> toFields() {
    if (deliveryType == 'home') {
      return {
        'paper_order_color_id': paperOrderColorId.toString(),
        'paper_option_data': jsonEncode(paperOptionData),
        'copy_numbers': copyNumbers.toString(),
        'page_numbers': pageNumbers.toString(),
        'user_id': userId.toString(),
        'delivery_type': deliveryType.toString(),
        'city_id': cityId.toString(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'address': address.toString(),
        'street': street.toString(),
        'floor_number': floorNumber.toString(),
        'flat_number': flatNumber.toString(),
      };
    } else {
      return {
        'paper_order_color_id': paperOrderColorId.toString(),
        'paper_option_data': jsonEncode(paperOptionData),
        'copy_numbers': copyNumbers.toString(),
        'page_numbers': pageNumbers.toString(),
        'user_id': userId.toString(),
        'delivery_type': deliveryType.toString(),
        'branch_id': branchId.toString(),
      };
    }
  }
}
