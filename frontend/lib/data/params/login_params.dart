class SignInParams {
  final String phone;
  final String password;

  SignInParams({
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'password': password,
    };
  }
}
