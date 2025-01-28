class CheckOtpPrams {
  final String phone;
  final String otp;

  CheckOtpPrams(this.phone, this.otp);

  Map<String, String> toMap() {
    return {
      'phone': phone,
      'otp': otp,
    };
  }
}
