// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'option_data_model.g.dart';

@HiveType(typeId: 0)
class OptionDataModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final num price;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final num totalCost;
  bool isSelected;
  num totalPrice;

  OptionDataModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.totalCost,
    this.isSelected = false,
    this.totalPrice = 0,
  });

  factory OptionDataModel.fromMap(Map<String, dynamic> map) {
    return OptionDataModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      price: num.tryParse('${map['price']}') ?? 0,
      image: map['image'] ?? '',
      totalCost: num.tryParse('${map['total_cost']}') ??
          num.tryParse('${map['price']}') ??
          0,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
