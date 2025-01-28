import 'package:dartz/dartz.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/data/models/career_model.dart';
import 'package:ibn_sina/data/models/city_model.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/app_remote_data_source.dart';
import '../models/branch_model.dart';
import '../models/settings_model.dart';
import '../params/contact_us_params.dart';

import '../../core/api/api_response.dart';
import '../../core/failures/api_exception.dart';
import '../../core/failures/app_failure.dart';
import '../models/intro_model.dart';
import '../models/page_model.dart';

class AppRepository {
  final AppRemoteDataSource _appRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  AppRepository(
    this._appRemoteDataSource,
    this._userLocalDataSource,
  );

  Future<Either<AppFailure, ApiResponse<List<IntroModel>>>>
      getIntroData() async {
    try {
      final response = await _appRemoteDataSource.getIntroData();
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<BranchModel>>>>
      getBranches() async {
    try {
      final response = await _appRemoteDataSource.getBranches(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<CityModel>>>> getCities() async {
    try {
      final response = await _appRemoteDataSource.getCities(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<PageModel>>> getAboutApp() async {
    try {
      final response = await _appRemoteDataSource.getAboutApp(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<PageModel>>> getPolicy() async {
    try {
      final response = await _appRemoteDataSource.getPolicy(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<PageModel>>> getTerms(
    String? apiToken,
  ) async {
    try {
      final response = await _appRemoteDataSource.getTerms(
        apiToken ?? _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<SettingsModel>>>
      getAppSettings() async {
    try {
      final response = await _appRemoteDataSource.getAppSettings(
        _userLocalDataSource.getUserData().apiToken,
      );
      locator<SharedData>()
        ..tax = response.data.tax
        ..shippingCost = response.data.shippingCost;
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> contactUs(
    ContactUsParams params,
  ) async {
    try {
      final response = await _appRemoteDataSource.contactUs(params);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<CareerModel>>>> getCareerLevels(
      [String? apiToken]) async {
    try {
      final response = await _appRemoteDataSource.getCareerLevels(
        apiToken ?? _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }
}
