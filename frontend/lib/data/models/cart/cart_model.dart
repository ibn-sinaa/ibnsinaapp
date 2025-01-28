import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../amount/amount_model.dart';
import '../option_data/option_data_model.dart';
import '../option_model/option_model.dart';
import '../product/product_model.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 2)
class CartModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int productId;
  @HiveField(2)
  final String productName;
  @HiveField(3)
  final String productImage;
  @HiveField(4)
  final AmountModel amount;
  @HiveField(5)
  final num totalPrice;
  @HiveField(6)
  final List<OptionDataModel> options;
  @HiveField(7)
  final List<DefaultOptionModel> defaultOptions;
  @HiveField(8)
  final String? filePath;
  @HiveField(9)
  final String message;
  @HiveField(10)
  final DateTime createdAt;
  @HiveField(11)
  final List<OptionModel> optionsModels;

  const CartModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.amount,
    required this.totalPrice,
    required this.options,
    required this.defaultOptions,
    this.filePath,
    required this.message,
    required this.createdAt,
    required this.optionsModels,
  });

  factory CartModel.init() {
    return CartModel(
      id: '',
      productId: 0,
      productName: '',
      productImage: '',
      amount: AmountModel.init(),
      totalPrice: 0,
      options: const [],
      defaultOptions: const [],
      message: '',
      createdAt: DateTime.now(),
      optionsModels: const [],
    );
  }

  factory CartModel.generateCart(
    ProductModel productModel,
    List<DefaultOptionModel> defaultOptions,
  ) {
    final firstAmount = productModel.amounts.isEmpty
        ? AmountModel.init()
        : productModel.amounts.first;

    return CartModel(
      id: '',
      productId: productModel.id,
      productName: productModel.title,
      productImage: productModel.mainImage,
      amount: firstAmount,
      totalPrice:
          firstAmount.offer != 0 ? firstAmount.offer : firstAmount.value,
      options: const [],
      defaultOptions: defaultOptions,
      message: '',
      createdAt: DateTime.now(),
      optionsModels: const [],
    );
  }

  CartModel copyWith({
    String? id,
    int? productId,
    String? productName,
    String? productImage,
    AmountModel? amount,
    num? totalPrice,
    List<OptionDataModel>? options,
    List<DefaultOptionModel>? defaultOptions,
    String? filePath,
    DateTime? createdAt,
    String? message,
    bool removeFilePath = false,
    List<OptionModel>? optionsModels,
  }) {
    return CartModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      amount: amount ?? this.amount,
      totalPrice: totalPrice ?? this.totalPrice,
      options: options ?? this.options,
      defaultOptions: defaultOptions ?? this.defaultOptions,
      filePath: removeFilePath ? null : filePath ?? this.filePath,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      optionsModels: optionsModels ?? this.optionsModels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': productId,
      'amount_id': amount.id,
      'message': message.trim(),
      'options': options
          .map(
            (option) => option.id,
          )
          .toList(),
    };
  }

  @override
  List<Object?> get props => [
        amount,
        totalPrice,
        options,
        filePath,
        createdAt,
        message,
        optionsModels,
      ];
}
