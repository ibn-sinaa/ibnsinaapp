class CreateNewPasswordParams {
  final String phone;
  final String otp;
  final String password;

  CreateNewPasswordParams(
    this.phone,
    this.otp,
    this.password,
  );

  Map<String, String> toMap() {
    return {
      'phone': phone,
      'otp': otp,
      'password': password,
    };
  }
}
