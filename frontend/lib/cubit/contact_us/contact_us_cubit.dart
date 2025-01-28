import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/enums.dart';
import '../../data/params/contact_us_params.dart';
import '../../data/repositories/app_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final AppRepository _appRepository;
  final UserRepository _userRepository;

  ContactUsCubit(
    this._appRepository,
    this._userRepository,
  ) : super(ContactUsState.init());

  getUserData() {
    final userModel = _userRepository.getUserData();
    Future.delayed(Duration.zero, () {
      emit(state.copyWith(
        userName: userModel.userName,
        phone: userModel.phone,
        email: userModel.email,
      ));
    });
  }

  userNameChanged(String userName) {
    emit(state.copyWith(
      userName: userName,
      requestState: RequestState.none,
    ));
  }

  phoneChanged(String phone) {
    emit(state.copyWith(
      phone: phone,
      requestState: RequestState.none,
    ));
  }

  emailChanged(String email) {
    emit(state.copyWith(
      email: email,
      requestState: RequestState.none,
    ));
  }

  messageChanged(String message) {
    emit(state.copyWith(
      message: message,
      requestState: RequestState.none,
    ));
  }

  contactUs(GlobalKey<FormState> formState) async {
    if (formState.currentState!.validate()) {
      emit(state.copyWith(
        requestState: RequestState.loading,
        refreshState: !state.refreshState,
      ));
      final responseEither = await _appRepository.contactUs(
        ContactUsParams(
          userName: state.userName,
          phone: state.phone,
          email: state.email,
          message: state.message,
        ),
      );
      responseEither.fold(
        (failure) {
          emit(state.copyWith(
            requestState: RequestState.error,
            requestMessage: failure.message,
          ));
        },
        (response) {
          emit(state.copyWith(
            requestState: RequestState.loaded,
            requestMessage: response.message,
            showError: false,
            message: '',
          ));
        },
      );
    } else {
      emit(state.copyWith(showError: true));
    }
  }
}
