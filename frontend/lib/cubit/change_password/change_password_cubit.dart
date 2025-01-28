import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/enums.dart';
import '../../data/params/change_password_params.dart';

import '../../data/repositories/profile_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ProfileRepository _profileRepository;

  ChangePasswordCubit(this._profileRepository)
      : super(ChangePasswordState.init());

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

  changePassword(GlobalKey<FormState> formState) async {
    if (formState.currentState!.validate()) {
      emit(state.copyWith(
        requestState: RequestState.loading,
      ));
      final userModelEither = await _profileRepository.changePassword(
        ChangePasswordParams(
          state.currentPassword,
          state.newPassword,
          state.confirmNewPassword,
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
            message: response.message,
          ));
        },
      );
    } else {
      emit(state.copyWith(showError: true));
    }
  }
}
