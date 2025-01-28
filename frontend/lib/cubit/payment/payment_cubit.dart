import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import '../../core/utils/enums.dart';
import '../../data/repositories/orders_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final OrdersRepository _ordersRepository;
  final UserRepository _userRepository;

  PaymentCubit(
    this._ordersRepository,
    this._userRepository,
  ) : super(PaymentState.init());

  completePayment(String url, [OrderType? orderType]) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final responseEither = await _ordersRepository.completePayment(url);
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.error,
          message: AppStrings.sorryYourPaymentFailed.tr(),
        ));
      },
      (response) {
        if (orderType == OrderType.product) {
          _userRepository.clearCart();
        }
        emit(state.copyWith(
          requestState: RequestState.loaded,
          message: response.message,
        ));
      },
    );
  }
}
