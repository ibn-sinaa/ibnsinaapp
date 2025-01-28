import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/api/api_response.dart';
import '../../core/api/status_code.dart';
import '../../core/utils/app_strings.dart';
import '../params/check_otp_params.dart';
import '../params/create_account_params.dart';

import '../../../../core/failures/api_exception.dart';
import '../../../../core/failures/app_failure.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/auth_remote_data_source.dart';
import '../models/user_model.dart';
import '../params/login_params.dart';
import '../params/create_new_password_params.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  AuthRepository(
    this._authRemoteDataSource,
    this._userLocalDataSource,
  );

  Future<Either<AppFailure, ApiResponse>> registerPhone(
    String phone,
  ) async {
    try {
      final response = await _authRemoteDataSource.registerPhone(phone);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> checkOtp(
    CheckOtpPrams params,
  ) async {
    try {
      final response = await _authRemoteDataSource.checkOtp(params);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> createAccount(
    CreateAccountParams params,
  ) async {
    try {
      final response = await _authRemoteDataSource.createAccount(params);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<UserModel>>> signIn(
    SignInParams params,
  ) async {
    try {
      final response = await _authRemoteDataSource.signIn(params);
      if (!response.data.phoneVerified) {
        return Left(AppFailure(
          AppStrings.theAccountIsNotActivated.tr(),
          StatusCode.unauthorized,
        ));
      }
      authenticateUser(response.data);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> forgotPassword(
    String phone,
  ) async {
    try {
      final response = await _authRemoteDataSource.forgotPassword(phone);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> resendOtp(
    String phone,
  ) async {
    try {
      final response = await _authRemoteDataSource.resendOtp(phone);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> createNewPassword(
    CreateNewPasswordParams params,
  ) async {
    try {
      final response = await _authRemoteDataSource.createNewPassword(params);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  authenticateUser(UserModel userModel) {
    _userLocalDataSource.saveUserData(userModel);
    _userLocalDataSource.saveUserAuthenticatedStatus(true);
    _userLocalDataSource.saveFirstTimeStatus();
  }
}
