import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final int id;
  final String name;
  const CityModel({
    required this.id,
    required this.name,
  });

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  @override
  List<Object> get props => [id, name];
}
