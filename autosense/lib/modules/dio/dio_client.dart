import 'dart:io';

import 'package:autosense/config/app_config.dart';
import 'package:autosense/modules/dio/interceptors/api_error_interceptor.dart';
import 'package:autosense/modules/dio/interceptors/bad_network_error_interceptor.dart';
import 'package:autosense/modules/dio/interceptors/internal_server_error_interceptor.dart';
import 'package:autosense/modules/dio/interceptors/unathenticated_interceptor.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:universal_platform/universal_platform.dart';

Dio initDioClient() {
  final dio = Dio();
  final baseUrl = AppConfig.getEnv('BASE_URL');
  final env = AppConfig.getEnv('ENV');
  final connectTimeout = int.tryParse(AppConfig.getEnv('CONNECT_TIMEOUT')) ??
      const Duration(seconds: 10).inMilliseconds;
  final receiveTimeout = int.tryParse(AppConfig.getEnv('RECEIVE_TIMEOUT')) ??
      const Duration(seconds: 10).inMilliseconds;

  if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
    /// Allows https requests for older devices.
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      return client;
    };
  }

  dio.options.baseUrl = baseUrl;
  dio.options.headers['Accept-Language'] =
      UniversalPlatform.isWeb ? 'en-US' : Platform.localeName.substring(0, 2);
  dio.options.connectTimeout = connectTimeout;
  dio.options.receiveTimeout = receiveTimeout;
  dio.interceptors.add(BadNetworkErrorInterceptor());
  dio.interceptors.add(InternalServerErrorInterceptor());
  dio.interceptors.add(ApiErrorInterceptor());
  dio.interceptors.add(UnauthenticatedInterceptor());

  if (env == 'develop') {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
  }

  return dio;
}
