import 'dart:io';

class SendQuotationRequestParams {
  final String userName;
  final String phone;
  final String email;
  final String message;
  final File? file;

  const SendQuotationRequestParams({
    required this.userName,
    required this.phone,
    required this.email,
    required this.message,
    required this.file,
  });

  Map<String, String> toMap() {
    return {
      'username': userName,
      'phone': phone,
      'email': email,
      'message': message,
    };
  }
}
