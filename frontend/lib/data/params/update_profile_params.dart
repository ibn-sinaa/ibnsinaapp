import 'package:ibn_sina/core/utils/enums.dart';

class UpdateProfileParams {
  final String userName;
  final String email;
  final String educationLevel;
  final String? universityName;
  final int careerLevelId;

  UpdateProfileParams({
    required this.userName,
    required this.email,
    required this.educationLevel,
    required this.careerLevelId,
    required this.universityName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': userName,
      'email': email,
      'education_level': educationLevel,
      'university':
          educationLevel != EducationalLevel.university ? universityName : '',
      'employment_type_id': careerLevelId.toString(),
    };
  }
}
