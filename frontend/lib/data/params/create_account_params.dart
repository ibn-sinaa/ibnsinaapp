import 'package:easy_localization/easy_localization.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';

class CreateAccountParams {
  final String apiToken;
  final String userName;
  final String password;
  final String educationLevel;
  final String? universityName;
  final int careerLevelId;

  CreateAccountParams({
    required this.apiToken,
    required this.userName,
    required this.password,
    required this.educationLevel,
    required this.careerLevelId,
    required this.universityName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': userName,
      'password': password,
      'password_confirmation': password,
      'education_level': educationLevel,
      'university':
          educationLevel != AppStrings.university.tr() ? '' : universityName,
      'employment_type_id': careerLevelId.toString(),
    };
  }
}
