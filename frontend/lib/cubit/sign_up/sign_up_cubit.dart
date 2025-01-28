import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';

import '../../core/utils/enums.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit(this._authRepository) : super(SignUpState.init());

  phoneChanged(String phone) {
    emit(state.copyWith(
      phone: phone,
      requestState: RequestState.none,
    ));
  }

  registerPhone(GlobalKey<FormState> formState) async {
    if (formState.currentState!.validate()) {
      emit(state.copyWith(
        requestState: RequestState.loading,
        refreshState: !state.refreshState,
      ));

      final userModelEither = await _authRepository.registerPhone(
        state.phone,
      );
      userModelEither.fold(
        (failure) {
          emit(state.copyWith(
            requestState: RequestState.error,
            message: failure.message,
          ));
        },
        (response) {
          emit(state.copyWith(
            requestState: RequestState.loaded,
            message: response.message,
          ));
        },
      );
    } else {
      emit(state.copyWith(showError: true));
    }
  }
}
