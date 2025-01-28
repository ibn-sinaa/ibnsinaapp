import 'package:dartz/dartz.dart';
import 'package:ibn_sina/data/models/media_order_model.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';
import 'package:ibn_sina/data/models/option_model/option_model.dart';
import 'package:ibn_sina/data/models/paper_order_model.dart';
import 'package:ibn_sina/data/params/make_media_order_params.dart';
import 'package:ibn_sina/data/params/make_paper_order_params.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/orders_remote_data_source.dart';
import '../models/product_order_model.dart';
import '../params/make_product_order_params.dart';

import '../../core/api/api_response.dart';
import '../../core/failures/api_exception.dart';
import '../../core/failures/app_failure.dart';
import '../models/coupon_model.dart';
import '../params/orders_params.dart';

class OrdersRepository {
  final OrdersRemoteDataSource _ordersRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  OrdersRepository(
    this._ordersRemoteDataSource,
    this._userLocalDataSource,
  );

  Future<Either<AppFailure, ApiResponse<List<ProductOrderModel>>>>
      getProductOrders(OrdersParams params) async {
    try {
      final response = await _ordersRemoteDataSource.getProductOrders(
        params,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<ProductOrderModel>>>
      getProductOrderDetails(int id) async {
    try {
      final response = await _ordersRemoteDataSource.getProductOrderDetails(
        id,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<CouponModel>>> checkCoupon(
    String coupon,
  ) async {
    try {
      final response = await _ordersRemoteDataSource.checkCoupon(
        coupon,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> makeProductOrder(
    MakeProductOrderParams params,
  ) async {
    try {
      final response = await _ordersRemoteDataSource.makeProductOrder(
        params,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<PaperOrderModel>>>> getPaperOrders(
      OrdersParams params) async {
    try {
      final response = await _ordersRemoteDataSource.getPaperOrders(
        params,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<PaperOrderModel>>> getPaperOrderDetails(
      int id) async {
    try {
      final response = await _ordersRemoteDataSource.getPaperOrderDetails(
        id,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<OptionDataModel>>>>
      getPaperColors() async {
    try {
      final response = await _ordersRemoteDataSource.getPaperColors(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<OptionModel>>>>
      getPaperOptions() async {
    try {
      final response = await _ordersRemoteDataSource.getPaperOptions(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> makePaperOrder(
    MakePaperOrderParams params,
  ) async {
    try {
      final response = await _ordersRemoteDataSource.makePaperOrder(
        params,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<MediaOrderModel>>>> getMediaOrders(
      OrdersParams params) async {
    try {
      final response = await _ordersRemoteDataSource.getMediaOrders(
        params,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<MediaOrderModel>>> getMediaOrderDetails(
      int id) async {
    try {
      final response = await _ordersRemoteDataSource.getMediaOrderDetails(
        id,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse<List<OptionDataModel>>>>
      getMediaMaterials() async {
    try {
      final response = await _ordersRemoteDataSource.getMediaMaterials(
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> makeMediaOrder(
    MakeMediaOrderParams params,
  ) async {
    try {
      final response = await _ordersRemoteDataSource.makeMediaOrder(
        params,
        _userLocalDataSource.getUserData().apiToken,
      );
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }

  Future<Either<AppFailure, ApiResponse>> completePayment(
    String url,
  ) async {
    try {
      final response = await _ordersRemoteDataSource.completePayment(url);
      return Right(response);
    } on ApiException catch (error) {
      return Left(AppFailure(error.message, error.statusCode));
    }
  }
}
