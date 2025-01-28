class QuotationRequestModel {
  final int id;
  final String userName;
  final String email;
  final String phone;
  final String message;
  final String status;
  final String image;
  final String notes;
  final num price;

  QuotationRequestModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phone,
    required this.message,
    required this.status,
    required this.image,
    required this.notes,
    required this.price,
  });

  factory QuotationRequestModel.fromMap(Map<String, dynamic> map) {
    return QuotationRequestModel(
      id: map['id'] ?? 0,
      userName: map['username'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      message: map['message'] ?? '',
      status: map['status'] ?? '',
      image: map['image'] ?? '',
      notes: map['note']?.toString() ?? '',
      price: num.tryParse('${map['price']}') ?? 0,
    );
  }
}
