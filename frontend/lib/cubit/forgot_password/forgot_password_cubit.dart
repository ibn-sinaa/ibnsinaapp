import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/enums.dart';
import '../../data/params/create_new_password_params.dart';
import '../../data/repositories/auth_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordCubit(this._authRepository) : super(ForgotPasswordState.init());

  phoneChanged(String phone) {
    emit(state.copyWith(
      phone: phone,
      requestState: RequestState.none,
    ));
  }

  otpChanged(String otp) {
    emit(state.copyWith(
      otp: otp,
      requestState: RequestState.none,
    ));
  }

  currentPasswordChanged(String password) {
    emit(state.copyWith(
      currentPassword: password,
      requestState: RequestState.none,
    ));
  }

  toggleCurrentPasswordStatus() {
    emit(
      state.copyWith(
        showCurrentPassword: !state.showCurrentPassword,
        requestState: RequestState.none,
      ),
    );
  }

  newPasswordChanged(String password) {
    emit(state.copyWith(
      newPassword: password,
      requestState: RequestState.none,
    ));
  }

  toggleNewPasswordStatus() {
    emit(
      state.copyWith(
        showNewPassword: !state.showNewPassword,
        requestState: RequestState.none,
      ),
    );
  }

  confirmNewPasswordChanged(String password) {
    emit(state.copyWith(
      confirmNewPassword: password,
      requestState: RequestState.none,
    ));
  }

  toggleConfirmNewPasswordStatus() {
    emit(
      state.copyWith(
        showConfirmNewPassword: !state.showConfirmNewPassword,
        requestState: RequestState.none,
      ),
    );
  }

  forgotPassword(GlobalKey<FormState> formState) async {
    if (formState.currentState!.validate()) {
      emit(state.copyWith(
        requestState: RequestState.loading,
        refreshState: !state.refreshState,
      ));
      final userModelEither = await _authRepository.forgotPassword(
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
            forgotPasswordStep: ForgotPasswordStep.reset,
            message: response.message,
            showError: false,
          ));
        },
      );
    } else {
      emit(state.copyWith(showError: true));
    }
  }

  Future<bool> resendOtp() async {
    emit(state.copyWith(
      requestState: RequestState.loading,
      refreshState: !state.refreshState,
    ));
    final userModelEither = await _authRepository.resendOtp(state.phone);
    return userModelEither.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.error,
          message: failure.message,
        ));
        return false;
      },
      (response) {
        emit(state.copyWith(
          requestState: RequestState.loaded,
          message: response.message,
        ));
        return true;
      },
    );
  }

  createNewPassword(GlobalKey<FormState> formState) async {
    if (formState.currentState!.validate()) {
      emit(state.copyWith(
        requestState: RequestState.loading,
        refreshState: !state.refreshState,
      ));
      final userModelEither = await _authRepository.createNewPassword(
        CreateNewPasswordParams(
          state.phone,
          state.otp,
          state.newPassword,
        ),
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
            forgotPasswordStep: ForgotPasswordStep.success,
          ));
        },
      );
    } else {
      emit(state.copyWith(
        showError: true,
        requestState: RequestState.none,
      ));
    }
  }
}
