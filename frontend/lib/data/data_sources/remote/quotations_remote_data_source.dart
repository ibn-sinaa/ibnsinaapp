import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../../core/api/api_response.dart';
import '../../../core/failures/api_exception.dart';
import '../../models/quotation_request_model.dart';
import '../../params/send_quotation_request_params.dart';

class QuotationsRemoteDataSource {
  final ApiClient _apiClient;

  QuotationsRemoteDataSource(this._apiClient);

  Future<ApiResponse> sendQuotationRequest(
    SendQuotationRequestParams params,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.postMultiPart(
        ApiConstants.quotations,
        files: params.file == null ? {} : {'image': params.file!.path},
        fields: params.toMap(),
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (_) {},
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<List<QuotationRequestModel>>> getQuotationRequests(
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.quotations,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((quotaionRequest) =>
                  QuotationRequestModel.fromMap(quotaionRequest))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<QuotationRequestModel>> getQuotationRequestDetails(
    int id,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.quotations}/$id',
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return QuotationRequestModel.fromMap(data);
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }
}
