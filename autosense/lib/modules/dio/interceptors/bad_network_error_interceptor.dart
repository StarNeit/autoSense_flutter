import 'package:autosense/modules/dependency_injection/dependency_injection.dart';
import 'package:autosense/modules/dio/dio_exception_handler.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class BadNetworkErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response == null &&
        !await getIt<InternetConnectionCheckerPlus>().hasConnection) {
      return handler.reject(
        BadNetworkException(
          requestOptions: err.requestOptions,
        ),
      );
    }

    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return handler.next(options);
  }
}
