class PaymentModel {
  final bool status;
  final num invoiceId;
  final String invoiceURL;

  PaymentModel({
    required this.status,
    required this.invoiceId,
    required this.invoiceURL,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      status: map['status'] ?? false,
      invoiceId: map['invoiceId'] ?? 0,
      invoiceURL: map['InvoiceURL'] ?? '',
    );
  }
}
