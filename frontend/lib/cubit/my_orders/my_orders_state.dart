part of 'my_orders_cubit.dart';

class MyOrdersState extends Equatable {
  final RequestState requestState;
  final RequestState moreState;
  final String message;
  final List<ProductOrderModel> productOrders;
  final List<PaperOrderModel> paperOrders;
  final List<MediaOrderModel> mediaOrders;
  final int tapId;

  const MyOrdersState({
    required this.requestState,
    required this.moreState,
    required this.message,
    required this.productOrders,
    required this.paperOrders,
    required this.mediaOrders,
    required this.tapId,
  });

  factory MyOrdersState.init() {
    return const MyOrdersState(
      requestState: RequestState.none,
      moreState: RequestState.none,
      message: '',
      productOrders: [],
      paperOrders: [],
      mediaOrders: [],
      tapId: 0,
    );
  }

  MyOrdersState copyWith({
    RequestState? requestState,
    RequestState? moreState,
    String? message,
    List<ProductOrderModel>? productOrders,
    List<PaperOrderModel>? paperOrders,
    List<MediaOrderModel>? mediaOrders,
    int? tapId,
  }) {
    return MyOrdersState(
      requestState: requestState ?? this.requestState,
      moreState: moreState ?? this.moreState,
      message: message ?? this.message,
      productOrders: productOrders ?? this.productOrders,
      paperOrders: paperOrders ?? this.paperOrders,
      mediaOrders: mediaOrders ?? this.mediaOrders,
      tapId: tapId ?? this.tapId,
    );
  }

  @override
  List<Object> get props {
    return [
      requestState,
      moreState,
      message,
      productOrders,
      paperOrders,
      mediaOrders,
      tapId,
    ];
  }
}
