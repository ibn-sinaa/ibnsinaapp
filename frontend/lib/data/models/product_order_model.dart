import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/data/models/city_model.dart';

import 'branch_model.dart';
import 'product_item_model.dart';
import 'price_model.dart';

class ProductOrderModel {
  final int id;
  final BranchModel? branch;
  final CityModel? city;
  final String paymentStatus;
  final String invoiceId;
  final DeliveryType deliveryType;
  final double latitude;
  final double longitude;
  final String address;
  final String buildingNumber;
  final String floorNumber;
  final String apartmentNumber;
  final String policyNumber;
  final PriceModel prices;
  final String orderStatus;
  final String orderStatusLabel;
  final List<ProductItemModel> items;
  final String invoiceUrl;
  final String note;

  ProductOrderModel({
    required this.id,
    required this.branch,
    required this.city,
    required this.paymentStatus,
    required this.invoiceId,
    required this.deliveryType,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.buildingNumber,
    required this.floorNumber,
    required this.apartmentNumber,
    required this.policyNumber,
    required this.prices,
    required this.orderStatus,
    required this.orderStatusLabel,
    required this.items,
    required this.invoiceUrl,
    required this.note,
  });

  factory ProductOrderModel.fromMap(
      Map<String, dynamic> map, String invoiceUrl) {
    return ProductOrderModel(
      id: map['id'] as int,
      branch: map['branch'] != null ? BranchModel.fromMap(map['branch']) : null,
      city: map['city'] != null ? CityModel.fromMap(map['city']) : null,
      paymentStatus: map['payment_status'] as String? ?? '',
      invoiceId: map['invoiceId'] == null ? '' : '${map['invoiceId']}',
      deliveryType: DeliveryType.values
          .firstWhere((type) => type.key == map['delivery_type']),
      latitude: map['latitude'] == null ? 0.0 : double.parse(map['latitude']),
      longitude:
          map['longitude'] == null ? 0.0 : double.parse(map['longitude']),
      address: map['address'] as String? ?? '',
      buildingNumber: map['street'] as String? ?? '',
      floorNumber: map['floor_number'] as String? ?? '',
      apartmentNumber: map['flat_number'] as String? ?? '',
      policyNumber: map['policy_number'] as String? ?? '',
      prices: PriceModel.fromMap(map['prices']),
      orderStatus: map['order_status'] as String? ?? '',
      orderStatusLabel: map['order_status_label'] as String? ?? '',
      items: map['items'] == null
          ? []
          : (map['items'] as List)
              .map((item) => ProductItemModel.fromMap(item))
              .toList(),
      invoiceUrl: invoiceUrl,
      note: map['note'] as String? ?? '',
    );
  }
}
