import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'amount_model.g.dart';

@HiveType(typeId: 1)
class AmountModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final num key;
  @HiveField(2)
  final num value;
  @HiveField(3)
  final num offer;

  const AmountModel({
    required this.id,
    required this.key,
    required this.value,
    required this.offer,
  });

  factory AmountModel.init() {
    return const AmountModel(
      id: 0,
      key: 0,
      value: 0,
      offer: 0,
    );
  }

  factory AmountModel.fromMap(Map<String, dynamic> map) {
    return AmountModel(
      id: map['id'] ?? 0,
      key: num.tryParse(map['key']) ?? 0,
      value: num.tryParse(map['value']) ?? 0,
      offer: num.tryParse(map['offer']) ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        key,
        value,
        offer,
      ];
}
