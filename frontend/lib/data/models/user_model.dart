import 'dart:convert';

import 'package:ibn_sina/data/models/career_model.dart';

class UserModel {
  final int id;
  final String userName;
  final String image;
  final String email;
  final String phone;
  final String educationLevel;
  final String universityName;
  final CareerModel careerLevel;
  final String apiToken;
  final bool phoneVerified;
  final int? inReview;

  UserModel({
    required this.id,
    required this.userName,
    required this.image,
    required this.email,
    required this.phone,
    required this.educationLevel,
    required this.universityName,
    required this.careerLevel,
    required this.apiToken,
    required this.phoneVerified,
    required this.inReview,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': userName,
      'avatar': image,
      'email': email,
      'phone': phone,
      'education_level': educationLevel,
      'university': universityName,
      'employment_type': [careerLevel.toMap()],
      'api-token': apiToken,
      'phone_verified': phoneVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, [String? apiToken]) {
    return UserModel(
      id: map['id'] ?? 0,
      userName: map['username'] ?? '',
      image: map['avatar'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      educationLevel: map['education_level'] ?? '',
      universityName: map['university'] ?? '',
      careerLevel: CareerModel.fromMap(map['employment_type'][0]),
      apiToken: apiToken ?? map['api-token'] ?? '',
      phoneVerified: map['phone_verified'] ?? false,
      inReview: map['in_review'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
