class StatusCode {
  const StatusCode._();

  static const int ok = 200;
  static const int create = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int timeout = 408;
  static const int conflict = 409;
  static const int unSupportedMediaType = 415;
  static const int invalidFormat = 422;
  static const int noResponse = 444;
  static const int cancelledByUser = 499;
  static const int serverError = 500;
}
