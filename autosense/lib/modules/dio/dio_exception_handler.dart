import 'package:dio/dio.dart';

class BadNetworkException extends DioError implements Exception {
  BadNetworkException({required super.requestOptions});
}

class InternalServerException extends DioError implements Exception {
  InternalServerException({required super.requestOptions});
}

class UnauthenticatedException extends DioError implements Exception {
  UnauthenticatedException({required super.requestOptions});
}

class ApiException extends DioError implements Exception {
  ApiException({
    required this.errorMessage,
    required super.requestOptions,
    super.response,
    super.error,
    super.type,
  });

  final String errorMessage;
}

class InvalidJsonFormatException extends DioError implements Exception {
  InvalidJsonFormatException({required super.requestOptions});
}
