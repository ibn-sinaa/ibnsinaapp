import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/enums.dart';
import '../../data/models/cart/cart_model.dart';
import '../../data/models/coupon_model.dart';
import '../../data/repositories/orders_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final UserRepository _userRepository;
  final OrdersRepository _ordersRepository;

  CartCubit(
    this._userRepository,
    this._ordersRepository,
  ) : super(CartState.init());

  CouponModel? _couponModel;

  getInitialData() async {
    _couponModel = null;
    final cartItems = await _userRepository.getCartData();

    final num orderValue =
        cartItems.fold(0, (prev, current) => prev + current.totalPrice);

    emit(
      state.copyWith(
        cartItems: cartItems,
        orderValue: orderValue,
        orderValueAfterDiscount: orderValue,
        totalValue: orderValue,
      ),
    );
  }

  deleteCartItem(String id) {
    _userRepository.deleteCartBy(id);
    final cartItems = [...state.cartItems];
    final deletedcartItem =
        cartItems.firstWhere((cartItem) => cartItem.id == id);
    cartItems.remove(deletedcartItem);

    final num orderValue =
        cartItems.fold(0, (prev, current) => prev + current.totalPrice);

    num discountValue = state.discountValue;
    if (_couponModel != null) {
      discountValue = _couponModel!.type == 'fixed'
          ? _couponModel!.value
          : ((_couponModel!.value / 100) * orderValue);
    }

    emit(state.copyWith(
      cartItems: cartItems,
      couponState: RequestState.none,
      orderValue: orderValue,
      discountValue: discountValue,
      orderValueAfterDiscount: orderValue - discountValue,
      totalValue: orderValue - discountValue,
    ));
  }

  deleteCoupon() {
    _couponModel = null;
    emit(state.copyWith(
      couponState: RequestState.none,
      discountValue: 0,
      orderValueAfterDiscount: state.orderValue,
      totalValue: state.totalValue + state.discountValue,
      resetCoupon: true,
    ));
  }

  checkCoupon(String coupon) async {
    emit(state.copyWith(
      couponState: RequestState.loading,
    ));
    final responseEither = await _ordersRepository.checkCoupon(coupon);
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          couponState: RequestState.error,
          message: failure.message,
        ));
      },
      (response) {
        _couponModel = response.data;
        final discountValue = response.data.type == 'fixed'
            ? response.data.value
            : ((response.data.value / 100) * state.orderValue);

        emit(state.copyWith(
          couponState: RequestState.loaded,
          discountValue: discountValue,
          orderValueAfterDiscount: state.orderValue - discountValue,
          totalValue: state.orderValue - discountValue,
          couponId: _couponModel?.id,
        ));
      },
    );
  }

  Future<void> clearCart() async {
    await _userRepository.clearCart();
    emit(CartState.init());
  }
}
