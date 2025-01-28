part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  final RequestState requestState;
  final String message;

  const PaymentState({
    required this.requestState,
    required this.message,
  });

  factory PaymentState.init() {
    return const PaymentState(
      requestState: RequestState.none,
      message: '',
    );
  }
  PaymentState copyWith({
    RequestState? requestState,
    String? message,
  }) {
    return PaymentState(
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        requestState,
        message,
      ];
}
