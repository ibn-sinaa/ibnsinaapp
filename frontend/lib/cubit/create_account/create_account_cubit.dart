import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/data/models/career_model.dart';

import '../../core/utils/enums.dart';
import '../../data/params/check_otp_params.dart';
import '../../data/params/create_account_params.dart';
import '../../data/repositories/auth_repository.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final AuthRepository _authRepository;
  final String phone;

  CreateAccountCubit(
    this._authRepository,
    this.phone,
  ) : super(CreateAccountState.init());

  String _apiToken = '';
  String get apiToken => _apiToken;

  void userNameChanged(String userName) {
    emit(state.copyWith(
      userName: userName,
      requestState: RequestState.none,
      showAgreeError: false,
    ));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(
      password: password,
      requestState: RequestState.none,
      showAgreeError: false,
    ));
  }

  void togglePasswordStatus() {
    emit(
      state.copyWith(
        showPassword: !state.showPassword,
        requestState: RequestState.none,
        showAgreeError: false,
      ),
    );
  }

  void confirmPasswordChanged(String confirmPassword) {
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      requestState: RequestState.none,
      showAgreeError: false,
    ));
  }

  void toggleConfirmPPasswordStatus() {
    emit(
      state.copyWith(
        showConfirmPassword: !state.showConfirmPassword,
        requestState: RequestState.none,
        showAgreeError: false,
      ),
    );
  }

  void toggleAgreeStatus() {
    emit(
      state.copyWith(
        isAgree: !state.isAgree,
        requestState: RequestState.none,
        showAgreeError: false,
      ),
    );
  }

  void educationalLevelChanged(EducationalLevel educationalLevel) {
    emit(state.copyWith(
      educationalLevel: educationalLevel,
      requestState: RequestState.none,
      showAgreeError: false,
    ));
  }

  void universityNameChanged(String universityName) {
    emit(state.copyWith(
      universityName: universityName,
      requestState: RequestState.none,
      showAgreeError: false,
    ));
  }

  void careerLevelChanged(CareerModel careerLevel) {
    emit(state.copyWith(
      careerLevel: careerLevel,
      requestState: RequestState.none,
      showAgreeError: false,
    ));
  }

  void checkOtp(String otp) async {
    emit(state.copyWith(
      requestState: RequestState.loading,
      refreshState: !state.refreshState,
    ));

    final responseEither = await _authRepository.checkOtp(
      CheckOtpPrams(phone, otp),
    );
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.error,
          message: failure.message,
        ));
      },
      (response) {
        _apiToken = response.apiToken;
        emit(state.copyWith(
          requestState: RequestState.loaded,
          createAccountStep: CreateAccountStep.create,
        ));
      },
    );
  }

  Future<bool> resendOtp() async {
    emit(state.copyWith(
      requestState: RequestState.loading,
      refreshState: !state.refreshState,
    ));
    final userModelEither = await _authRepository.registerPhone(phone);
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

  void createAccount(GlobalKey<FormState> formState) async {
    if (!formState.currentState!.validate()) {
      emit(state.copyWith(
        showError: true,
        showAgreeError: false,
        requestState: RequestState.none,
      ));
    } else if (state.educationalLevel == null) {
      emit(state.copyWith(
        requestState: RequestState.error,
        message: AppStrings.pleaseSelectEducationalLevel.tr(),
        refreshState: !state.refreshState,
      ));
    } else if (state.careerLevel == null) {
      emit(state.copyWith(
        requestState: RequestState.error,
        message: AppStrings.pleaseSelectCareerLevel.tr(),
        refreshState: !state.refreshState,
      ));
    } else if (!state.isAgree) {
      emit(state.copyWith(
        showAgreeError: true,
        refreshState: !state.refreshState,
      ));
    } else {
      emit(state.copyWith(
        requestState: RequestState.loading,
        refreshState: !state.refreshState,
      ));

      final userModelEither = await _authRepository.createAccount(
        CreateAccountParams(
          apiToken: _apiToken,
          userName: state.userName,
          password: state.password,
          educationLevel: state.educationalLevel!.key,
          universityName: state.universityName,
          careerLevelId: state.careerLevel!.id,
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
            createAccountStep: CreateAccountStep.success,
          ));
        },
      );
    }
  }
}
