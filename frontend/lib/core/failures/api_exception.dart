import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../api/status_code.dart';
import '../utils/app_strings.dart';

abstract class ApiException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const ApiException(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class BadRequestException extends ApiException {
  BadRequestException([String? message])
      : super(
          message ?? AppStrings.badRequestException.tr(),
          StatusCode.badRequest,
        );
}

class UnAuthorizedException extends ApiException {
  UnAuthorizedException([String? message])
      : super(
          message ?? AppStrings.unauthorizedException.tr(),
          StatusCode.unauthorized,
        );
}

class ForbiddenException extends ApiException {
  ForbiddenException([String? message])
      : super(
          message ?? AppStrings.forbiddenException.tr(),
          StatusCode.forbidden,
        );
}

class NotFoundException extends ApiException {
  NotFoundException([String? message])
      : super(
          message ?? AppStrings.notFoundException.tr(),
          StatusCode.notFound,
        );
}

class TimeEndException extends ApiException {
  TimeEndException()
      : super(
          AppStrings.timeoutException.tr(),
          StatusCode.timeout,
        );
}

class ConflictException extends ApiException {
  ConflictException([String? message])
      : super(
          message ?? AppStrings.conflictException.tr(),
          StatusCode.conflict,
        );
}

class UnSupportedMediaTypeException extends ApiException {
  const UnSupportedMediaTypeException(String message)
      : super(message, StatusCode.unSupportedMediaType);
}

class InvalidFormatException extends ApiException {
  InvalidFormatException()
      : super(
          AppStrings.invalidFormatException.tr(),
          StatusCode.invalidFormat,
        );
}

class NoResponseException extends ApiException {
  NoResponseException()
      : super(
          AppStrings.noResponseException.tr(),
          StatusCode.noResponse,
        );
}

class CancelledByUserException extends ApiException {
  const CancelledByUserException(String message)
      : super(message, StatusCode.cancelledByUser);
}

class ServerErrorException extends ApiException {
  ServerErrorException([String? message])
      : super(
          message ?? AppStrings.serverErrorException.tr(),
          StatusCode.serverError,
        );
}

class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException()
      : super(
          AppStrings.noInternetConnectionException.tr(),
          1,
        );
}

class UnKnownException extends ApiException {
  UnKnownException([String? message, int? statusCode])
      : super(
          message ?? AppStrings.somethingWentWrongException.tr(),
          statusCode ?? 2,
        );
}

class CacheException extends ApiException {
  const CacheException(String message) : super(message, 0);
}
