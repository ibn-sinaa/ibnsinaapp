import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../../core/api/api_response.dart';
import '../../../core/failures/api_exception.dart';
import '../../models/category/category_model.dart';
import '../../models/home_model.dart';
import '../../models/option_model/option_model.dart';
import '../../models/product_details_model.dart';
import '../../models/product/product_model.dart';
import '../../models/slider_model.dart';
import '../../params/search_params.dart';

class ProductsRemoteDataSource {
  final ApiClient _apiClient;

  ProductsRemoteDataSource(this._apiClient);

  Future<ApiResponse<List<SliderModel>>> getHomeSliders(String apiToken) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.homeSlider,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((slider) => SliderModel.fromMap(slider))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<List<HomeModel>>> getHomeData(String apiToken) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.home,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((productList) => HomeModel.fromMap(productList))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<List<CategoryModel>>> getCategories(
    String apiToken,
    int? id,
  ) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.categories}${id == null ? '' : '/$id'}',
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((category) => CategoryModel.fromMap(category))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<List<ProductModel>>> searchForProducts(
    String apiToken,
    SearchParams params,
  ) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.search,
        body: params.toMap(),
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((product) => ProductModel.fromMap(product))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<ProductDetailsModel>> getProductDetails(
    String apiToken,
    int productId,
  ) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.products}/$productId',
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return ProductDetailsModel(
            ProductModel.fromMap(data),
            (response['options'] as List)
                .map((option) => OptionModel.fromMap(option))
                .toList(),
          );
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }
}
