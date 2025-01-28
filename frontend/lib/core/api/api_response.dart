import '../../data/models/paginate_model.dart';
import '../../data/models/payment_model.dart';

class ApiResponse<T> {
  final int code;
  final String message;
  final List<String> errors;
  final T data;
  final int otp;
  final String apiToken;
  final PaginateModel? paginate;
  final PaymentModel? payment;

  ApiResponse._({
    required this.code,
    required this.message,
    required this.errors,
    required this.data,
    required this.otp,
    required this.apiToken,
    this.paginate,
    this.payment,
  });

  factory ApiResponse.fromMap(
    Map<String, dynamic> map, {
    required T Function(dynamic data) builder,
  }) {
    return ApiResponse<T>._(
      code: map['code'] ?? 0,
      message: map['message'] ?? '',
      errors: (map['errors'] as List)
          .map<String>((error) => error['value'])
          .toList(),
      data: builder(map['data']),
      otp: map['otp'] ?? 0,
      apiToken: map['api_token'] ?? '',
      paginate: map['paginate'] == null
          ? null
          : PaginateModel.fromMap(map['paginate']),
      payment:
          map['payment'] == null ? null : PaymentModel.fromMap(map['payment']),
    );
  }
}
