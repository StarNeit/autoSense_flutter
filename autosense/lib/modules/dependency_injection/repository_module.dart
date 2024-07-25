import 'package:autosense/features/fuel_finder/networking/station_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@module
abstract class RepositoryModule {
  @singleton
  StationRepository provideStationRepository(Dio dio) => StationRepository(dio);
}
