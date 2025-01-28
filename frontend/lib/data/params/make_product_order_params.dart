import 'dart:convert';

import '../models/cart/cart_model.dart';

class MakeProductOrderParams {
  final int userId;
  final String deliveryType;
  final int? branchId;
  final int? cityId;
  final int? couponId;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? street;
  final String? floorNumber;
  final String? flatNumber;
  final List<CartModel> cartItems;

  MakeProductOrderParams({
    required this.userId,
    required this.deliveryType,
    required this.branchId,
    required this.cityId,
    required this.couponId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.street,
    required this.floorNumber,
    required this.flatNumber,
    required this.cartItems,
  });

  Map<String, String> toFields() {
    final encodedProducts = jsonEncode(
      cartItems.map((item) => item.toMap()).toList(),
    );
    Map<String, String> couponMap = {};
    if (couponId != null) {
      couponMap = {
        'coupon_id': couponId.toString(),
      };
    }

    if (deliveryType == 'home') {
      return {
        ...couponMap,
        'user_id': userId.toString(),
        'delivery_type': deliveryType.toString(),
        'city_id': cityId.toString(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'address': address.toString(),
        'street': street.toString(),
        'floor_number': floorNumber.toString(),
        'flat_number': flatNumber.toString(),
        'products': encodedProducts,
      };
    } else {
      return {
        ...couponMap,
        'user_id': userId.toString(),
        'delivery_type': deliveryType.toString(),
        'branch_id': branchId.toString(),
        'products': encodedProducts,
      };
    }
  }

  Map<String, String> toFiles() {
    Map<String, String> files = {};

    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].filePath != null) {
        files['images[$i]'] = cartItems[i].filePath!;
      }
    }
    return files;
  }
}
