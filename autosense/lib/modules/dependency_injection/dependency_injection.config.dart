// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i4;

import '../../features/fuel_finder/networking/station_repository.dart' as _i5;
import 'dio_client_di.dart' as _i6;
import 'network_info_di.dart' as _i7;
import 'repository_module.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final dioInjection = _$DioInjection();
  final networkInfoInjection = _$NetworkInfoInjection();
  final repositoryModule = _$RepositoryModule();
  gh.singleton<_i3.Dio>(dioInjection.dio());
  gh.factory<_i4.InternetConnectionCheckerPlus>(
      () => networkInfoInjection.networkInfo);
  gh.singleton<_i5.StationRepository>(
      repositoryModule.provideStationRepository(get<_i3.Dio>()));
  return get;
}

class _$DioInjection extends _i6.DioInjection {}

class _$NetworkInfoInjection extends _i7.NetworkInfoInjection {}

class _$RepositoryModule extends _i8.RepositoryModule {}
