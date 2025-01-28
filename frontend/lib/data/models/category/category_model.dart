import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'category_model.g.dart';

@HiveType(typeId: 5)
class CategoryModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int productCount;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.productCount,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      productCount: map['productCount'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, name, productCount];
}
