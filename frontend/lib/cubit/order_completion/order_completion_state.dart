part of 'order_completion_cubit.dart';

class OrderCompletionState extends Equatable {
  final RequestState requestState;
  final RequestState makeOrderState;
  final String message;
  final int errorType;
  final bool refreshData;
  final String invoiceUrl;
  final BranchModel? branch;
  final CityModel? city;
  final LocationModel location;
  final DeliveryType deliveryType;

  const OrderCompletionState({
    required this.requestState,
    required this.makeOrderState,
    required this.message,
    required this.errorType,
    required this.refreshData,
    required this.invoiceUrl,
    this.branch,
    this.city,
    required this.location,
    required this.deliveryType,
  });

  factory OrderCompletionState.initial() {
    return OrderCompletionState(
      requestState: RequestState.none,
      makeOrderState: RequestState.none,
      message: '',
      errorType: 0,
      refreshData: false,
      invoiceUrl: '',
      location: LocationModel(),
      deliveryType: DeliveryType.branch,
    );
  }

  OrderCompletionState copyWith({
    RequestState? requestState,
    RequestState? makeOrderState,
    String? message,
    int? errorType,
    bool? refreshData,
    String? invoiceUrl,
    BranchModel? branch,
    CityModel? city,
    LocationModel? location,
    DeliveryType? deliveryType,
  }) {
    return OrderCompletionState(
      requestState: requestState ?? this.requestState,
      makeOrderState: makeOrderState ?? this.makeOrderState,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
      refreshData: refreshData ?? this.refreshData,
      invoiceUrl: invoiceUrl ?? this.invoiceUrl,
      branch: branch ?? this.branch,
      city: city ?? this.city,
      location: location ?? this.location,
      deliveryType: deliveryType ?? this.deliveryType,
    );
  }

  @override
  List<Object?> get props {
    return [
      requestState,
      makeOrderState,
      message,
      errorType,
      refreshData,
      invoiceUrl,
      branch,
      city,
      location,
      deliveryType,
    ];
  }
}
