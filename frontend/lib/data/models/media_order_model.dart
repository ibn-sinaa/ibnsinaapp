import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/data/models/branch_model.dart';
import 'package:ibn_sina/data/models/city_model.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';
import 'package:ibn_sina/data/models/price_model.dart';

class MediaOrderModel {
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
  final List<MediaItemModel> items;
  final String invoiceUrl;

  MediaOrderModel({
    required this.id,
    this.branch,
    this.city,
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
  });

  factory MediaOrderModel.fromMap(Map<String, dynamic> map, String invoiceUrl) {
    return MediaOrderModel(
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
          : List<MediaItemModel>.from(
              (map['items'] as List).map<MediaItemModel>(
                (item) => MediaItemModel.fromMap(item),
              ),
            ),
      invoiceUrl: invoiceUrl,
    );
  }
}

class MediaItemModel {
  final int id;
  final OptionDataModel material;
  final int height;
  final int width;
  final int copyNumbers;
  final num totalPrice;
  final String fileUploaded;
  MediaItemModel({
    required this.id,
    required this.material,
    required this.height,
    required this.width,
    required this.copyNumbers,
    required this.totalPrice,
    required this.fileUploaded,
  });

  factory MediaItemModel.fromMap(Map<String, dynamic> map) {
    return MediaItemModel(
      id: map['id'] as int,
      material:
          OptionDataModel.fromMap(map['material'] as Map<String, dynamic>),
      height: int.parse('${map['length']}'),
      width: int.parse('${map['width']}'),
      copyNumbers: int.parse('${map['copy_numbers']}'),
      totalPrice: num.parse('${map['total_price']}'),
      fileUploaded: map['file_uploaded'] as String,
    );
  }
}
