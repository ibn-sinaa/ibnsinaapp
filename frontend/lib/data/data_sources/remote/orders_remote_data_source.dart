import 'package:ibn_sina/data/models/media_order_model.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';
import 'package:ibn_sina/data/models/option_model/option_model.dart';
import 'package:ibn_sina/data/models/paper_order_model.dart';
import 'package:ibn_sina/data/params/make_media_order_params.dart';
import 'package:ibn_sina/data/params/make_paper_order_params.dart';

import '../../../core/api/api_client.dart';
import '../../models/product_order_model.dart';
import '../../params/orders_params.dart';

import '../../../core/api/api_constants.dart';
import '../../../core/api/api_response.dart';
import '../../../core/failures/api_exception.dart';
import '../../models/coupon_model.dart';
import '../../params/make_product_order_params.dart';

class OrdersRemoteDataSource {
  final ApiClient _apiClient;

  OrdersRemoteDataSource(this._apiClient);

  Future<ApiResponse<List<ProductOrderModel>>> getProductOrders(
    OrdersParams params,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.productOrders,
        parameters: params.toParams(),
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((order) => ProductOrderModel.fromMap(order, ''))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<ProductOrderModel>> getProductOrderDetails(
    int id,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.productOrders}/$id',
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return ProductOrderModel.fromMap(
            data,
            response['payment']?['InvoiceURL'] ?? '',
          );
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<CouponModel>> checkCoupon(
    String coupon,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.checkCoupon,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
        body: {
          'code': coupon,
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return CouponModel.fromMap(data);
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> makeProductOrder(
    MakeProductOrderParams params,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.postMultiPart(
        ApiConstants.productOrders,
        files: params.toFiles(),
        fields: params.toFields(),
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

  Future<ApiResponse<List<PaperOrderModel>>> getPaperOrders(
    OrdersParams params,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.paperOrders,
        parameters: params.toParams(),
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map(
                (order) => PaperOrderModel.fromMap(order, ''),
              )
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<PaperOrderModel>> getPaperOrderDetails(
    int id,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.paperOrders}/$id',
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return PaperOrderModel.fromMap(
            data,
            response['payment']?['InvoiceURL'] ?? '',
          );
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<List<OptionDataModel>>> getPaperColors(
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.paperColors,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((printingColor) => OptionDataModel.fromMap(printingColor))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<List<OptionModel>>> getPaperOptions(
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.paperOptions,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((option) => OptionModel.fromMap(option))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> makePaperOrder(
    MakePaperOrderParams params,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.postMultiPart(
        ApiConstants.paperOrders,
        files: {'file_uploaded': params.fileUploaded},
        fields: params.toFields(),
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

  Future<ApiResponse<List<MediaOrderModel>>> getMediaOrders(
    OrdersParams params,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.mediaOrders,
        parameters: params.toParams(),
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map(
                (order) => MediaOrderModel.fromMap(order, ''),
              )
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<MediaOrderModel>> getMediaOrderDetails(
    int id,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.mediaOrders}/$id',
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return MediaOrderModel.fromMap(
            data,
            response['payment']?['InvoiceURL'] ?? '',
          );
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<List<OptionDataModel>>> getMediaMaterials(
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.mediaMaterials,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((printingColor) => OptionDataModel.fromMap(printingColor))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> makeMediaOrder(
    MakeMediaOrderParams params,
    String apiToken,
  ) async {
    try {
      final response = await _apiClient.postMultiPart(
        ApiConstants.mediaOrders,
        files: params.toFiles(),
        fields: params.toFields(),
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

  Future<ApiResponse> completePayment(String url) async {
    try {
      final response = await _apiClient.get(
        '',
        url: url,
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
