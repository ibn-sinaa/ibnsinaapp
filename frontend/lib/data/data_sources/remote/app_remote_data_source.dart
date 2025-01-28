import 'package:ibn_sina/data/models/career_model.dart';
import 'package:ibn_sina/data/models/city_model.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../../core/api/api_response.dart';
import '../../../core/failures/api_exception.dart';
import '../../models/branch_model.dart';
import '../../models/intro_model.dart';
import '../../models/page_model.dart';
import '../../models/settings_model.dart';
import '../../params/contact_us_params.dart';

class AppRemoteDataSource {
  final ApiClient _apiClient;

  AppRemoteDataSource(this._apiClient);

  Future<ApiResponse<List<IntroModel>>> getIntroData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final response = await _apiClient.get(
        ApiConstants.intro,
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) =>
            (data as List).map((intro) => IntroModel.fromMap(intro)).toList(),
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<List<BranchModel>>> getBranches(String apiToken) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.branches,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((branch) => BranchModel.fromMap(branch))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<List<CityModel>>> getCities(String apiToken) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.cities,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List).map((city) => CityModel.fromMap(city)).toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<PageModel>> getAboutApp(String apiToken) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.aboutApp,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return PageModel.fromMap(data);
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<PageModel>> getPolicy(String apiToken) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.policy,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return PageModel.fromMap(data);
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<PageModel>> getTerms(String apiToken) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.terms,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return PageModel.fromMap(data);
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<SettingsModel>> getAppSettings(String apiToken) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.settings,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return SettingsModel.fromMap(data);
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse> contactUs(ContactUsParams params) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.contactUs,
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

  Future<ApiResponse<List<CareerModel>>> getCareerLevels(
      String apiToken) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.careerLevels,
        headers: {
          ApiConstants.authorization: '${ApiConstants.bearer} $apiToken'
        },
      );
      return ApiResponse.fromMap(
        response,
        builder: (data) {
          return (data as List)
              .map((career) => CareerModel.fromMap(career))
              .toList();
        },
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }
}
