import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/data/models/branch_model.dart';
import 'package:ibn_sina/data/models/city_model.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';
import 'package:ibn_sina/data/models/option_model/option_model.dart';
import 'package:ibn_sina/data/models/price_model.dart';

class PaperOrderModel {
  final int id;
  final OptionDataModel paperColor;
  final BranchModel? branch;
  final CityModel? city;
  final String fileUploaded;
  final int pageNumbers;
  final int copyNumbers;
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
  final List<PaperItemModel> items;
  final String invoiceUrl;

  PaperOrderModel({
    required this.id,
    required this.paperColor,
    required this.branch,
    required this.city,
    required this.fileUploaded,
    required this.pageNumbers,
    required this.copyNumbers,
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

  factory PaperOrderModel.fromMap(Map<String, dynamic> map, String invoiceUrl) {
    return PaperOrderModel(
      id: map['id'] as int,
      paperColor: OptionDataModel.fromMap(map['paper_color'][0]),
      branch: map['branch'] != null ? BranchModel.fromMap(map['branch']) : null,
      city: map['city'] != null ? CityModel.fromMap(map['city']) : null,
      fileUploaded: map['file_uploaded'] as String,
      pageNumbers: map['page_numbers'] as int,
      copyNumbers: map['copy_numbers'] as int,
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
          : List<PaperItemModel>.from(
              (map['items'] as List).map<PaperItemModel>(
                (item) => PaperItemModel.fromMap(item),
              ),
            ),
      invoiceUrl: invoiceUrl,
    );
  }
}

class PaperItemModel {
  final int id;
  final OptionModel paperOption;
  final OptionDataModel paperOptionData;
  final num optionCost;

  PaperItemModel({
    required this.id,
    required this.paperOption,
    required this.paperOptionData,
    required this.optionCost,
  });

  factory PaperItemModel.fromMap(Map<String, dynamic> map) {
    return PaperItemModel(
      id: map['id'] as int,
      paperOption: OptionModel.fromMap(map['paper_option']),
      paperOptionData: OptionDataModel.fromMap(map['paper_option_data']),
      optionCost: num.parse('${map['option_cost']}'),
    );
  }
}
