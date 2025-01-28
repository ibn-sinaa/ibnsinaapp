part of 'cart_cubit.dart';

class CartState extends Equatable {
  final RequestState couponState;
  final String message;
  final List<CartModel> cartItems;
  final num orderValue;
  final num orderValueAfterDiscount;
  final num discountValue;
  final num totalValue;
  final int? couponId;

  const CartState({
    required this.couponState,
    required this.message,
    required this.cartItems,
    required this.orderValue,
    required this.orderValueAfterDiscount,
    required this.discountValue,
    required this.totalValue,
    this.couponId,
  });

  factory CartState.init() {
    return const CartState(
      couponState: RequestState.none,
      message: '',
      cartItems: [],
      orderValue: 0,
      orderValueAfterDiscount: 0,
      discountValue: 0,
      totalValue: 0,
    );
  }

  CartState copyWith({
    RequestState? couponState,
    String? message,
    String? invoiceUrl,
    List<CartModel>? cartItems,
    num? orderValue,
    num? orderValueAfterDiscount,
    num? discountValue,
    num? totalValue,
    int? couponId,
    bool resetData = false,
    bool resetCoupon = false,
  }) {
    return CartState(
      couponState:
          resetData ? RequestState.none : couponState ?? this.couponState,
      message: resetData ? '' : message ?? this.message,
      cartItems: resetData ? [] : cartItems ?? this.cartItems,
      orderValue: resetData ? 0 : orderValue ?? this.orderValue,
      orderValueAfterDiscount: resetData
          ? 0
          : orderValueAfterDiscount ?? this.orderValueAfterDiscount,
      discountValue: resetData ? 0 : discountValue ?? this.discountValue,
      totalValue: resetData ? 0 : totalValue ?? this.totalValue,
      couponId: (resetData || resetCoupon) ? null : couponId ?? this.couponId,
    );
  }

  @override
  List<Object?> get props {
    return [
      couponState,
      message,
      cartItems,
      orderValue,
      orderValueAfterDiscount,
      discountValue,
      totalValue,
      couponId,
    ];
  }
}
