import 'package:dartz/dartz.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/quotations_remote_data_source.dart';
import '../models/quotation_request_model.dart';

import '../../core/api/api_response.dart';
import '../../core/failures/api_exception.dart';
import '../../core/failures/app_failure.dart';
import '../params/send_quotation_request_params.dart';

class QuotationsRepository {
  final QuotationsRemoteDataSource _quotationsRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  QuotationsRepository(
    this._quotationsRemoteDataSource,
    this._userLocalDataSource,
  );

  Future<Either<AppFailure, ApiResponse>> sendQuotationRequest(
    SendQuotationRequestParams params,
  ) async {
    try {
      final response = await _quotationsRemoteDataSource.sendQuotationRequest(
        params,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<QuotationRequestModel>>>>
      getQuotationRequests() async {
    try {
      final response = await _quotationsRemoteDataSource.getQuotationRequests(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<QuotationRequestModel>>>
      getQuotationRequestDetails(int id) async {
    try {
      final response =
          await _quotationsRemoteDataSource.getQuotationRequestDetails(
        id,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }
}
