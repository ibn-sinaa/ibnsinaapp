import 'dart:io';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../../core/api/api_response.dart';
import '../../../core/failures/api_exception.dart';
import '../../models/notification_model.dart';
import '../../models/user_model.dart';
import '../../params/change_password_params.dart';
import '../../params/update_profile_params.dart';

class ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSource(this._apiClient);

  Future<ApiResponse> changePassword(
    ChangePasswordParams params,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.changePassword,
        body: params.toMap(),
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

  Future<ApiResponse> signOut(String apiToken) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.signOut,
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

  Future<ApiResponse<UserModel>> getMyProfile(String apiToken) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.myProfile,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return UserModel.fromMap(data, apiToken);
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<UserModel>> updateMyProfile(
    UpdateProfileParams params,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.myProfile,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
        body: params.toMap(),
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return UserModel.fromMap(data, apiToken);
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<UserModel>> updateMyProfileImage(
    File file,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.postMultiPart(
        ApiConstants.profileImage,
        files: {'avatar': file.path},
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return UserModel.fromMap(data, apiToken);
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<List<NotificationModel>>> getNotifications(
    String apiToken,
    int page,
  ) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.notifications,
        parameters: {'page': page.toString()},
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((notification) => NotificationModel.fromMap(notification))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> deleteNotification(
    String apiToken,
    int id,
  ) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.notifications}/$id/delete',
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

  Future<ApiResponse> deleteAccount(String apiToken) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.deleteAccount,
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
}
