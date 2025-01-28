part of 'quotation_request_cubit.dart';

abstract class QuotationRequestState extends Equatable {
  const QuotationRequestState();

  @override
  List<Object> get props => [];
}

class QuotationRequestInitial extends QuotationRequestState {}

class QuotationRequestLoading extends QuotationRequestState {}

class QuotationRequestsLoaded extends QuotationRequestState {
  final List<QuotationRequestModel> quotationRequests;

  const QuotationRequestsLoaded(this.quotationRequests);

  @override
  List<Object> get props => [quotationRequests];
}

class QuotationRequestDetailsLoaded extends QuotationRequestState {
  final QuotationRequestModel quotationRequest;

  const QuotationRequestDetailsLoaded(this.quotationRequest);

  @override
  List<Object> get props => [quotationRequest];
}

class QuotationRequestError extends QuotationRequestState {
  final String message;

  const QuotationRequestError(this.message);

  @override
  List<Object> get props => [message];
}
