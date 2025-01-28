import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/data/repositories/user_repository.dart';

import '../../../data/params/login_params.dart';
import '../../core/utils/enums.dart';
import '../../data/repositories/auth_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SignInCubit(this._authRepository, this._userRepository)
      : super(SignInState.init());

  phoneChanged(String phone) {
    emit(state.copyWith(
      phone: phone,
      requestState: RequestState.none,
    ));
  }

  passwordChanged(String password) {
    emit(state.copyWith(
      password: password,
      requestState: RequestState.none,
    ));
  }

  togglePasswordStatus() {
    emit(
      state.copyWith(
        showPassword: !state.showPassword,
        requestState: RequestState.none,
      ),
    );
  }

  signIn(GlobalKey<FormState> formState, {bool isGuest = false}) async {
    if (isGuest) {
      emit(state.copyWith(
        requestState: RequestState.loading,
        refreshState: !state.refreshState,
      ));
      final responseEither = await _authRepository.signIn(
        SignInParams(
          phone: '0503572205',
          password: '123456789',
        ),
      );
      responseEither.fold(
        (failure) {
          emit(state.copyWith(
            requestState: RequestState.error,
            message: failure.message,
          ));
        },
        (_) {
          locator<SharedData>().isGuest = true;
          _userRepository.saveGuestUser(true);
          emit(state.copyWith(requestState: RequestState.loaded));
        },
      );
    } else {
      if (formState.currentState!.validate()) {
        emit(state.copyWith(
          requestState: RequestState.loading,
          refreshState: !state.refreshState,
        ));
        final responseEither = await _authRepository.signIn(
          SignInParams(
            phone: state.phone,
            password: state.password,
          ),
        );
        responseEither.fold(
          (failure) {
            emit(state.copyWith(
              requestState: RequestState.error,
              message: failure.message,
            ));
          },
          (_) {
            _userRepository.saveGuestUser(false);
            locator<SharedData>().isGuest = false;
            emit(state.copyWith(requestState: RequestState.loaded));
          },
        );
      } else {
        emit(state.copyWith(showError: true));
      }
    }
  }
}
