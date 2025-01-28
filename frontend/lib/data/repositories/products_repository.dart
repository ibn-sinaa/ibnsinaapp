import 'package:dartz/dartz.dart';

import '../../core/api/api_response.dart';
import '../../core/api/status_code.dart';
import '../../core/failures/api_exception.dart';
import '../../core/failures/app_failure.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/products_remote_data_source.dart';
import '../models/category/category_model.dart';
import '../models/home_model.dart';
import '../models/product_details_model.dart';
import '../models/product/product_model.dart';
import '../models/slider_model.dart';
import '../params/search_params.dart';

class ProductsRepository {
  final ProductsRemoteDataSource _productsRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  ProductsRepository(
    this._productsRemoteDataSource,
    this._userLocalDataSource,
  );

  Future<Either<AppFailure, ApiResponse<List<SliderModel>>>>
      getHomeSliders() async {
    try {
      final response = await _productsRemoteDataSource.getHomeSliders(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      if (error.statusCode == StatusCode.unauthorized) {
        _unauthenticateUser();
      }
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<CategoryModel>>>> getCategories([
    int? id,
  ]) async {
    try {
      final response = await _productsRemoteDataSource.getCategories(
        _userLocalDataSource.getUserData().apiToken,
        id,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<ProductModel>>>> searchForProducts(
    SearchParams params,
  ) async {
    try {
      final response = await _productsRemoteDataSource.searchForProducts(
        _userLocalDataSource.getUserData().apiToken,
        params,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<HomeModel>>>> getHomeData() async {
    try {
      final response = await _productsRemoteDataSource.getHomeData(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<ProductDetailsModel>>>
      getProductDetails(int productId) async {
    try {
      final response = await _productsRemoteDataSource.getProductDetails(
        _userLocalDataSource.getUserData().apiToken,
        productId,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  _unauthenticateUser() {
    _userLocalDataSource.clearUserData();
    _userLocalDataSource.saveUserAuthenticatedStatus(false);
  }
}
