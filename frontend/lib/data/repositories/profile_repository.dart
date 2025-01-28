import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/failures/api_exception.dart';
import '../../../../core/failures/app_failure.dart';
import '../../core/api/api_response.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/profile_remote_data_source.dart';
import '../models/notification_model.dart';
import '../models/user_model.dart';
import '../params/change_password_params.dart';
import '../params/update_profile_params.dart';

class ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  ProfileRepository(
    this._profileRemoteDataSource,
    this._userLocalDataSource,
  );

  Future<Either<AppFailure, ApiResponse>> changePassword(
    ChangePasswordParams params,
  ) async {
    try {
      final response = await _profileRemoteDataSource.changePassword(
        params,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> signOut() async {
    try {
      final response = await _profileRemoteDataSource.signOut(
        _userLocalDataSource.getUserData().apiToken,
      );
      unauthenticateUser();
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<UserModel>>> getMyProfile() async {
    try {
      final response = await _profileRemoteDataSource.getMyProfile(
        _userLocalDataSource.getUserData().apiToken,
      );
      _userLocalDataSource.saveUserData(response.data);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<UserModel>>> updateMyProfile(
      UpdateProfileParams params) async {
    try {
      final response = await _profileRemoteDataSource.updateMyProfile(
        params,
        _userLocalDataSource.getUserData().apiToken,
      );
      _userLocalDataSource.saveUserData(response.data);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<UserModel>>> updateMyProfileImage(
    File file,
  ) async {
    try {
      final response = await _profileRemoteDataSource.updateMyProfileImage(
        file,
        _userLocalDataSource.getUserData().apiToken,
      );
      _userLocalDataSource.saveUserData(response.data);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<NotificationModel>>>>
      getNotifications(int page) async {
    try {
      final response = await _profileRemoteDataSource.getNotifications(
        _userLocalDataSource.getUserData().apiToken,
        page,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> deleteNotification(int id) async {
    try {
      final response = await _profileRemoteDataSource.deleteNotification(
        _userLocalDataSource.getUserData().apiToken,
        id,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> deleteAccount() async {
    try {
      final response = await _profileRemoteDataSource.deleteAccount(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  void unauthenticateUser() {
    _userLocalDataSource.clearUserData();
    _userLocalDataSource.saveUserAuthenticatedStatus(false);
  }
}
