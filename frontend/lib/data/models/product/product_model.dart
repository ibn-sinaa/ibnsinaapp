import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../amount/amount_model.dart';
import '../category/category_model.dart';
import '../option_model/option_model.dart';

part 'product_model.g.dart';

@HiveType(typeId: 6)
class ProductModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final num price;
  @HiveField(4)
  final num offerPrice;
  @HiveField(5)
  final num startAmount;
  @HiveField(6)
  final List<AmountModel> amounts;
  @HiveField(7)
  final List<DefaultOptionModel> defaultOptions;
  @HiveField(8)
  final String mainImage;
  @HiveField(9)
  final List<String> images;
  @HiveField(10)
  final List<CategoryModel> categories;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.offerPrice,
    required this.startAmount,
    required this.amounts,
    required this.defaultOptions,
    required this.mainImage,
    required this.images,
    required this.categories,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    List<DefaultOptionModel> options = [];
    if (map['defaultOptions'] != null) {
      options = (map['defaultOptions'] as List)
          .map((defaultOption) => DefaultOptionModel.fromMap(defaultOption))
          .toList();
    }
    return ProductModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: num.tryParse(map['price']?.toString() ?? '0') ?? 0,
      offerPrice: num.tryParse(map['offer_price']?.toString() ?? '0') ?? 0,
      startAmount: num.tryParse(map['start_amount']?.toString() ?? '0') ?? 0,
      amounts: map['amounts'] == null
          ? []
          : (map['amounts'] as List)
              .map((amount) => AmountModel.fromMap(amount))
              .toList()
        ..sort((a, b) => a.key.compareTo(b.key)),
      defaultOptions: options,
      images: map['images'] == null
          ? []
          : (map['images'] as List)
              .map<String>((image) => image['image'])
              .toList(),
      mainImage: map['main_image'] ?? '',
      categories: map['categories'] == null
          ? []
          : (map['categories'] as List)
              .map((category) => CategoryModel.fromMap(category))
              .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        offerPrice,
        startAmount,
        amounts,
        defaultOptions,
        mainImage,
        images,
        categories,
      ];
}
