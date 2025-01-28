class CouponModel {
  final int id;
  final String name;
  final String code;
  final num value;
  final String type;

  CouponModel({
    required this.id,
    required this.name,
    required this.code,
    required this.value,
    required this.type,
  });

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? 0,
      code: map['code'] ?? 0,
      value: num.tryParse(map['value']) ?? 0,
      type: map['type'] ?? 0,
    );
  }
}
