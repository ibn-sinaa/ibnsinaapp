import '../../params/check_otp_params.dart';
import '../../params/create_account_params.dart';
import '../../params/create_new_password_params.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../../core/api/api_response.dart';
import '../../../core/failures/api_exception.dart';
import '../../models/user_model.dart';
import '../../params/login_params.dart';

class AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSource(this._apiClient);

  Future<ApiResponse> registerPhone(String phone) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.registerPhone,
        body: {'phone': phone},
      );
      return ApiResponse.fromMap(
        response,
        builder: (_) {},
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> checkOtp(CheckOtpPrams params) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.checkOtp,
        body: params.toMap(),
      );
      return ApiResponse.fromMap(
        response,
        builder: (_) {},
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> createAccount(CreateAccountParams params) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.createAccount,
        body: params.toMap(),
        headers: {
          ApiConstants.authorization:
              '${ApiConstants.bearer} ${params.apiToken}'
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

  Future<ApiResponse<UserModel>> signIn(SignInParams params) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.signIn,
        body: params.toMap(),
      );

      return ApiResponse.fromMap(response, builder: (data) {
        return UserModel.fromMap(data, response['api_token']);
      });
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> forgotPassword(String phone) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.forgetPassword,
        body: {'phone': phone},
      );
      return ApiResponse.fromMap(
        response,
        builder: (_) {},
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> resendOtp(String phone) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.resendOtp,
        body: {'phone': phone},
      );
      return ApiResponse.fromMap(
        response,
        builder: (_) {},
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> createNewPassword(CreateNewPasswordParams params) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.newPassword,
        body: params.toMap(),
      );
      return ApiResponse.fromMap(
        response,
        builder: (_) {},
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }
}
