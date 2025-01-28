import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ibn_sina/data/models/media_order_model.dart';
import 'package:ibn_sina/data/models/paper_order_model.dart';
import 'package:ibn_sina/data/models/product_order_model.dart';
import 'package:ibn_sina/data/repositories/orders_repository.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(
    this._ordersRepository,
    this.id,
  ) : super(OrderDetailsInitial());

  final OrdersRepository _ordersRepository;
  final int id;

  getProductOrderDetails() async {
    emit(OrderDetailsLoading());

    final responseEither = await _ordersRepository.getProductOrderDetails(id);
    responseEither.fold(
      (failure) {
        emit(OrderDetailsError(failure.message));
      },
      (response) {
        emit(OrderDetailsLoaded(productOrder: response.data));
      },
    );
  }

  getPaperOrderDetails() async {
    emit(OrderDetailsLoading());

    final responseEither = await _ordersRepository.getPaperOrderDetails(id);
    responseEither.fold(
      (failure) {
        emit(OrderDetailsError(failure.message));
      },
      (response) {
        emit(OrderDetailsLoaded(paperOrder: response.data));
      },
    );
  }

  getMediaOrderDetails() async {
    emit(OrderDetailsLoading());

    final responseEither = await _ordersRepository.getMediaOrderDetails(id);
    responseEither.fold(
      (failure) {
        emit(OrderDetailsError(failure.message));
      },
      (response) {
        emit(OrderDetailsLoaded(mediaOrder: response.data));
      },
    );
  }
}
