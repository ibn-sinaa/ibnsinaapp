import 'package:easy_localization/easy_localization.dart';

import '../utils/app_strings.dart';

class ValidatorHelper {
  const ValidatorHelper._();

  static String? validateText(String? text, String errorMessage) {
    if (text!.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? validateUserName(String? userName) {
    if (userName!.trim().isEmpty) {
      return AppStrings.userNameIsRequired.tr();
    }
    return null;
  }

  static String? validateEmailAddress(String? emailAddress) {
    if (emailAddress!.trim().isEmpty) {
      return AppStrings.emailIsRequired.tr();
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailAddress.trim())) {
      return AppStrings.invalidEmail.tr();
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone!.trim().isEmpty) {
      return AppStrings.phoneNumberIsRequired.tr();
    } else if (phone.isNotEmpty && phone.length != 10) {
      return AppStrings.phoneNumberIsInvalid.tr();
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return AppStrings.passwordIsRequired.tr();
    } else if (password.length < 8) {
      return AppStrings.shortPassword.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? confirmPassword,
    String password,
  ) {
    if (confirmPassword != password) {
      return AppStrings.passwordNotMatched.tr();
    }
    return null;
  }

  static String? validateOtp(String? otp) {
    if (otp!.length < 4) {
      return AppStrings.pleaseEnterTheVerificationCode.tr();
    }
    return null;
  }

  static String? validateOtp1(String? otp) {
    if (otp!.length < 4) {
      return AppStrings.verificationCodeIsRequired.tr();
    }
    return null;
  }
}
