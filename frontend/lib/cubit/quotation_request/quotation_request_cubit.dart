import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/quotation_request_model.dart';
import '../../data/repositories/quotations_repository.dart';

part 'quotation_request_state.dart';

class QuotationRequestCubit extends Cubit<QuotationRequestState> {
  final QuotationsRepository _quotationsRepository;
  final int? id;

  QuotationRequestCubit(
    this._quotationsRepository, [
    this.id,
  ]) : super(QuotationRequestInitial());

  getQuotationRequests() async {
    emit(QuotationRequestLoading());
    final responseEither = await _quotationsRepository.getQuotationRequests();
    responseEither.fold(
      (failure) => emit(QuotationRequestError(failure.message)),
      (response) => emit(QuotationRequestsLoaded(response.data)),
    );
  }

  getQuotationRequestDetails() async {
    emit(QuotationRequestLoading());
    final responseEither =
        await _quotationsRepository.getQuotationRequestDetails(id!);
    responseEither.fold(
      (failure) => emit(QuotationRequestError(failure.message)),
      (response) => emit(QuotationRequestDetailsLoaded(response.data)),
    );
  }
}
