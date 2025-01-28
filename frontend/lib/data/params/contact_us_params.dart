class ContactUsParams {
  final String userName;
  final String phone;
  final String email;
  final String message;

  const ContactUsParams({
    required this.userName,
    required this.phone,
    required this.email,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': userName,
      'phone': phone,
      'email': email,
      'message': message,
    };
  }
}
