import 'package:autosense/modules/dio/dio_exception_handler.dart';
import 'package:dio/dio.dart';

class UnauthenticatedInterceptor extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null &&
        err.response!.statusCode != null &&
        err.response!.statusCode! == 401) {
      return handler.reject(
        UnauthenticatedException(requestOptions: err.requestOptions),
      );
    }

    return handler.next(err);
  }
}
