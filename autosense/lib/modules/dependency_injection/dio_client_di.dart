import 'package:autosense/modules/dio/dio_client.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';

@module
abstract class DioInjection {
  @singleton
  Dio dio() => initDioClient();
}
