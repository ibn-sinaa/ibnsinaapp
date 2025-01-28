import 'dart:convert';

import 'package:ibn_sina/data/models/media_form_model.dart';

class MakeMediaOrderParams {
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
  final List<MediaFormModel> forms;

  MakeMediaOrderParams({
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
    required this.forms,
  });

  Map<String, String> toFields() {
    final materialList = <int>[];
    final heightList = <int>[];
    final widthList = <int>[];
    final copyiesCountList = <int>[];
    for (final form in forms) {
      materialList.add(form.materialType!.id);
      heightList.add(form.height);
      widthList.add(form.width);
      copyiesCountList.add(form.copiesCount);
    }

    final data = {
      'materials[material_id]': jsonEncode(materialList),
      'materials[length]': jsonEncode(heightList),
      'materials[width]': jsonEncode(widthList),
      'materials[copy_numbers]': jsonEncode(copyiesCountList),
    };

    if (deliveryType == 'home') {
      return {
        'user_id': userId.toString(),
        'delivery_type': deliveryType.toString(),
        'city_id': cityId.toString(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'address': address.toString(),
        'street': street.toString(),
        'floor_number': floorNumber.toString(),
        'flat_number': flatNumber.toString(),
        ...data,
      };
    } else {
      return {
        'user_id': userId.toString(),
        'delivery_type': deliveryType.toString(),
        'branch_id': branchId.toString(),
        ...data,
      };
    }
  }

  Map<String, String> toFiles() {
    Map<String, String> files = {};

    for (int i = 0; i < forms.length; i++) {
      files['materials[file_uploaded][$i]'] = forms[i].file!.path;
    }
    return files;
  }
}
