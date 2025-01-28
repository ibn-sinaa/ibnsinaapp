import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../failures/api_exception.dart';
import '../helpers/helper_functions.dart';
import 'api_constants.dart';
import 'status_code.dart';

class ApiClient {
  static const int _timeout = 120;

  Future<Map<String, dynamic>> get(
    String endPoint, {
    String? baseUrl,
    String? url,
    Map<String, dynamic>? parameters,
    Map<String, String>? headers,
    int? timeout,
  }) async {
    final uri = url != null
        ? Uri.parse(url)
        : Uri.http(ApiConstants.baseUrl, endPoint, parameters);
    log('******************* Request *********************');
    log(
      'method: GET\nurl: $uri\nheaders: ${ApiConstants.getHeaders(headers)}',
    );
    return await _requestServer(() async {
      final response = await http
          .get(
            uri,
            headers: ApiConstants.getHeaders(headers),
          )
          .timeout(
            Duration(seconds: timeout ?? _timeout),
          );

      return _handleStatusCode(response);
    });
  }

  Future<Map<String, dynamic>> post(
    String endPoint, {
    String? baseUrl,
    String? url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? parameters,
    Map<String, String>? headers,
    int? timeout,
  }) async {
    final uri = url != null
        ? Uri.parse(url)
        : Uri.http(ApiConstants.baseUrl, endPoint, parameters);
    log('******************* Request *********************');
    log(
      'method: POST\nurl: $uri\nheaders: ${ApiConstants.getHeaders(headers)}\nbody: $body',
    );
    return await _requestServer(() async {
      final response = await http
          .post(
            uri,
            body: body,
            headers: ApiConstants.getHeaders(headers),
          )
          .timeout(
            Duration(seconds: timeout ?? _timeout),
          );
      return _handleStatusCode(response);
    });
  }

  Future<Map<String, dynamic>> postMultiPart(
    String endPoint, {
    String? baseUrl,
    String? url,
    required Map<String, String> files,
    Map<String, String>? fields,
    Map<String, dynamic>? parameters,
    Map<String, String>? headers,
    int? timeout,
  }) async {
    final uri = url != null
        ? Uri.parse(url)
        : Uri.http(ApiConstants.baseUrl, endPoint, parameters);
    log('******************* Request *********************');
    log(
      'method: POST\nurl: $uri\nheaders: ${ApiConstants.getHeaders(headers)}\nfields: $fields\nfiles: $files',
    );

    return await _requestServer(() async {
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll(ApiConstants.getHeaders(headers));
      request.fields.addAll(fields ?? {});
      files.forEach((key, filePath) async {
        String fileName = filePath.split('/').last;
        final file = await http.MultipartFile.fromPath(
          key,
          filePath,
          filename: fileName,
        );
        request.files.add(file);
      });


      final response = await request.send().timeout(
            Duration(seconds: timeout ?? _timeout),
          );
      return _handleStatusCode(await http.Response.fromStream(response));
    });
  }

  Future<Map<String, dynamic>> _requestServer(
    Future<Map<String, dynamic>> Function() computation,
  ) async {
    try {
      return await computation();
    } on SocketException {
      throw NoInternetConnectionException();
    } on FormatException {
      throw InvalidFormatException();
    } on HttpException {
      throw NoResponseException();
    } on TimeoutException {
      throw TimeEndException();
    } on Exception catch (error) {
      log(error.toString());
      if (error is ApiException) {
        rethrow;
      }
      throw UnKnownException(error.toString());
    }
  }

  Map<String, dynamic> _handleStatusCode(http.Response response) {
    log('******************* Response ********************');
    log('status code ${response.statusCode}\nresult: ${json.decode(response.body)}');
    log('*************************************************');

    final body = json.decode(response.body);
    String? errorMessage;
    if (body['errors'] != null && body['errors'].isNotEmpty) {
      errorMessage = body['errors'][0]['value'];
    }
    switch (response.statusCode) {
      case StatusCode.ok:
        return body;
      case StatusCode.create:
        return body;
      case StatusCode.noContent:
        return body;
      case StatusCode.badRequest:
        throw BadRequestException(errorMessage);
      case StatusCode.unauthorized:
        throw UnAuthorizedException(errorMessage);
      case StatusCode.forbidden:
        throw ForbiddenException(errorMessage);
      case StatusCode.notFound:
        throw NotFoundException(errorMessage);
      case StatusCode.conflict:
        throw ConflictException(errorMessage);
      case StatusCode.serverError:
        throw ServerErrorException(errorMessage);
      default:
        throw UnKnownException(
          response.reasonPhrase,
          response.statusCode,
        );
    }
  }
}
