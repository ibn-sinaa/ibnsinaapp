import '../../config/config.dart';
import '../services/service_locator.dart';

class ApiConstants {
  const ApiConstants._();

  static const String baseUrl = 'ibnsinaapp.com';

  static const String intro = '/api/intros';
  static const String registerPhone = '/api/otp';
  static const String checkOtp = '/api/check-otp';
  static const String resendOtp = '/api/re-send';
  static const String createAccount = '/api/completed-data';
  static const String signIn = '/api/login';
  static const String otp = '/api/otp';
  static const String forgetPassword = '/api/forget-password';
  static const String newPassword = '/api/new-password';
  static const String signOut = '/api/my-profile/logout';
  static const String changePassword = '/api/my-profile/change-password';
  static const String myProfile = '/api/my-profile';
  static const String profileImage = '/api/my-profile/change-avatar';
  static const String branches = '/api/branches';
  static const String cities = '/api/cities';
  static const String aboutApp = '/api/pages/about';
  static const String policy = '/api/pages/policy';
  static const String terms = '/api/pages/terms';
  static const String settings = '/api/settings';
  static const String notifications = '/api/my-profile/notifications';
  static const String deleteAccount = '/api/my-profile/delete-account';
  static const String contactUs = '/api/send-message';
  static const String quotations = '/api/quotations';
  static const String homeSlider = '/api/sliders';
  static const String home = '/api/products/home';
  static const String products = '/api/products';
  static const String categories = '/api/categories';
  static const String search = '/api/search';
  static const String productOrders = '/api/orders';
  static const String checkCoupon = '/api/check-coupon';
  static const String paperColors = '/api/paper-orders-default-options';
  static const String paperOptions = '/api/paper-orders-options';
  static const String paperOrders = '/api/paper-orders';
  static const String mediaMaterials = '/api/materials';
  static const String mediaOrders = '/api/materials-orders';
  static const String careerLevels = '/api/employments';

  // headers
  static const String acceptLanguage = 'Accept-Language';
  static const String devicesToken = 'Devices-Token';
  static const String pushToken = 'Push-Token';
  static const String accept = 'Accept';
  static const String applicationJson = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';

  static Map<String, String> getHeaders(Map<String, String>? headers) {
    final config = locator<Config>();
    return {
      ...{
        accept: applicationJson,
        acceptLanguage: config.languageCode,
        devicesToken: config.deviceToken,
        pushToken: config.pushToken,
      },
      ...headers ?? {}
    };
  }
}
