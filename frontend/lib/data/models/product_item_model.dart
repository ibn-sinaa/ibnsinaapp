import 'option_model/option_model.dart';
import 'product_id_model.dart';

class ProductItemModel {
  final int id;
  final ProductIdModel productId;
  final num amount;
  final num productPrice;
  final List<DefaultOptionModel> options;
  final num optionsPrice;
  final num totalPrice;

  ProductItemModel({
    required this.id,
    required this.productId,
    required this.amount,
    required this.productPrice,
    required this.options,
    required this.optionsPrice,
    required this.totalPrice,
  });

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    return ProductItemModel(
      id: map['id'] ?? 0,
      productId: ProductIdModel.fromMap(map['product_id']),
      amount: num.tryParse('${map['amount']}') ?? 0,
      productPrice: num.tryParse('${map['product_price']}') ?? 0,
      options: map['options'] == null
          ? []
          : (map['options'] as List)
              .map((option) => DefaultOptionModel.fromMap(option))
              .toList(),
      optionsPrice: num.tryParse('${map['options_price']}') ?? 0,
      totalPrice: num.tryParse('${map['total_price']}') ?? 0,
    );
  }
}
