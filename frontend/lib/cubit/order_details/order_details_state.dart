part of 'order_details_cubit.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object?> get props => [];
}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsLoaded extends OrderDetailsState {
  final PaperOrderModel? paperOrder;
  final MediaOrderModel? mediaOrder;
  final ProductOrderModel? productOrder;

  const OrderDetailsLoaded({
    this.paperOrder,
    this.mediaOrder,
    this.productOrder,
  });

  @override
  List<Object?> get props => [paperOrder, mediaOrder, productOrder];
}

class OrderDetailsError extends OrderDetailsState {
  final String message;

  const OrderDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
