import 'dart:convert';

import 'package:equatable/equatable.dart';

class CareerModel extends Equatable {
  final int id;
  final String name;

  const CareerModel({
    required this.id,
    required this.name,
  });

  factory CareerModel.fromMap(Map<String, dynamic> map) {
    return CareerModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [id, name];
}
