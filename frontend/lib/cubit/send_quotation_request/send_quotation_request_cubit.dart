import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/enums.dart';
import '../../data/params/send_quotation_request_params.dart';
import '../../data/repositories/quotations_repository.dart';

part 'send_quotation_request_state.dart';

class SendQuotationRequestCubit extends Cubit<SendQuotationRequestState> {
  final QuotationsRepository _quotationsRepository;

  SendQuotationRequestCubit(this._quotationsRepository)
      : super(SendQuotationRequestState.init());

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

  sendQuotationRequest(
    GlobalKey<FormState> formState,
    File? design,
  ) async {
    if (formState.currentState!.validate()) {
      emit(state.copyWith(
        requestState: RequestState.loading,
        refreshState: !state.refreshState,
      ));

      final responseEither = await _quotationsRepository.sendQuotationRequest(
        SendQuotationRequestParams(
          userName: state.userName,
          phone: state.phone,
          email: state.email,
          message: state.message,
          file: design,
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
          ));
        },
      );
    } else {
      emit(state.copyWith(showError: true));
    }
  }
}
