import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/data/models/media_order_model.dart';
import 'package:ibn_sina/data/models/paper_order_model.dart';
import '../../core/utils/enums.dart';
import '../../data/models/product_order_model.dart';
import '../../data/params/orders_params.dart';
import '../../data/repositories/orders_repository.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  final OrdersRepository _ordersRepository;

  MyOrdersCubit(this._ordersRepository) : super(MyOrdersState.init());

  int _page = 1;
  int _lastPage = 1;

  getProductOrders({
    int? tapId,
    bool refresh = false,
  }) async {
    if (_startEmit(tapId, refresh) == false) {
      return;
    }
    final responseEither = await _ordersRepository.getProductOrders(params);
    responseEither.fold(
      (failure) {
        _emitFailure(failure.message);
      },
      (response) {
        if (_page == 1) {
          _lastPage = response.paginate!.lastPage;
          emit(state.copyWith(
            requestState: RequestState.loaded,
            productOrders: response.data,
          ));
        } else {
          final productOrders = [...state.productOrders];
          productOrders.addAll(response.data);
          emit(state.copyWith(
            moreState: RequestState.loaded,
            productOrders: productOrders,
          ));
        }
        _page++;
      },
    );
  }

  getPaperOrders({
    int? tapId,
    bool refresh = false,
  }) async {
    if (_startEmit(tapId, refresh) == false) {
      return;
    }
    final responseEither = await _ordersRepository.getPaperOrders(params);
    responseEither.fold(
      (failure) {
        _emitFailure(failure.message);
      },
      (response) {
        if (_page == 1) {
          _lastPage = response.paginate!.lastPage;
          emit(state.copyWith(
            requestState: RequestState.loaded,
            paperOrders: response.data,
          ));
        } else {
          final paperOrders = [...state.paperOrders];
          paperOrders.addAll(response.data);
          emit(state.copyWith(
            moreState: RequestState.loaded,
            paperOrders: paperOrders,
          ));
        }
        _page++;
      },
    );
  }

  getMediaOrders({
    int? tapId,
    bool refresh = false,
  }) async {
    if (_startEmit(tapId, refresh) == false) {
      return;
    }
    final responseEither = await _ordersRepository.getMediaOrders(params);
    responseEither.fold(
      (failure) {
        _emitFailure(failure.message);
      },
      (response) {
        if (_page == 1) {
          _lastPage = response.paginate!.lastPage;
          emit(state.copyWith(
            requestState: RequestState.loaded,
            mediaOrders: response.data,
          ));
        } else {
          final mediaOrders = [...state.mediaOrders];
          mediaOrders.addAll(response.data);
          emit(state.copyWith(
            moreState: RequestState.loaded,
            mediaOrders: mediaOrders,
          ));
        }
        _page++;
      },
    );
  }

  bool _startEmit(int? tapId, bool refresh) {
    tapId ??= state.tapId;
    if (tapId != state.tapId || refresh) {
      _page = 1;
    }
    if (_page > _lastPage || state.moreState == RequestState.loading) {
      return false;
    }
    if (_page == 1) {
      emit(state.copyWith(
        tapId: tapId,
        moreState: RequestState.none,
        requestState: RequestState.loading,
      ));
    } else {
      emit(state.copyWith(moreState: RequestState.loading));
    }
    return true;
  }

  OrdersParams get params => OrdersParams(
        orderStatus: state.tapId == 0 ? 'new' : 'old',
        page: _page,
      );

  void _emitFailure(String message) {
    if (_page == 1) {
      emit(state.copyWith(
        requestState: RequestState.error,
        message: message,
      ));
    } else {
      emit(state.copyWith(
        moreState: RequestState.error,
        message: message,
      ));
    }
  }
}

/*
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/core/api/api_response.dart';
import 'package:ibn_sina/core/failures/app_failure.dart';
import 'package:ibn_sina/data/models/paper_order_model.dart';
import '../../core/utils/enums.dart';
import '../../data/models/product_order_model.dart';
import '../../data/params/orders_params.dart';
import '../../data/repositories/orders_repository.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  final OrdersRepository _ordersRepository;

  MyOrdersCubit(this._ordersRepository) : super(MyOrdersState.init());

  int _page = 1;
  int _lastPage = 1;

  getOrders({
    required OrderType orderType,
    int? tapId,
    bool refresh = false,
  }) async {
    tapId ??= state.tapId;
    if (tapId != state.tapId || refresh) {
      _page = 1;
    }
    if (_page > _lastPage || state.moreState == RequestState.loading) {
      return;
    }
    if (_page == 1) {
      emit(state.copyWith(
        tapId: tapId,
        moreState: RequestState.none,
        requestState: RequestState.loading,
      ));
    } else {
      emit(state.copyWith(moreState: RequestState.loading));
    }
    final responseEither = await _getOrders(orderType);

    responseEither.fold(
      (failure) {
        if (_page == 1) {
          emit(state.copyWith(
            requestState: RequestState.error,
            message: failure.message,
          ));
        } else {
          emit(state.copyWith(
            moreState: RequestState.error,
            message: failure.message,
          ));
        }
      },
      (response) {
        if (_page == 1) {
          _lastPage = response.paginate!.lastPage;
          emit(state.copyWith(
            requestState: RequestState.loaded,
            productOrders: orderType.isProduct()
                ? response.data as List<ProductOrderModel>
                : null,
            paperOrders: orderType.isPaper()
                ? response.data as List<PaperOrderModel>
                : null,
          ));
        } else {
          final productOrders = [...state.productOrders];
          productOrders.addAll(response.data);
          emit(state.copyWith(
            moreState: RequestState.loaded,
            productOrders: productOrders,
          ));
        }
        _page++;
      },
    );
  }

  Future<Either<AppFailure, ApiResponse<List>>> _getOrders(
    OrderType orderType,
  ) async {
    final params = OrdersParams(
      orderStatus: state.tapId == 0 ? 'new' : 'old',
      page: _page,
    );

    switch (orderType) {
      case OrderType.product:
        return await _ordersRepository.getProductOrders(params);
      case OrderType.paper:
        return await _ordersRepository.getPaperOrders(params);
    }
  }
}

*/