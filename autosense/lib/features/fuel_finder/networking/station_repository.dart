import 'package:dio/dio.dart';
import '../models/station.dart';

class StationRepository {
  final Dio dioClient;

  StationRepository(this.dioClient);

  Future<List<Station>> fetchStations() async {
    try {
      final response = await dioClient.get(
        '/stations',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Station.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load stations');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load stations: ${e.message}');
    }
  }

  Future<void> updateStation(Station station) async {
    try {
      await dioClient.put(
        '/stations/${station.id}',
        data: station.toJson(),
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
    } on DioError catch (e) {
      throw Exception('Failed to update station: ${e.message}');
    }
  }

  Future<void> addStation(Station station) async {
    try {
      await dioClient.post(
        '/stations',
        data: station.toJson(),
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
    } on DioError catch (e) {
      throw Exception('Failed to add station: ${e.message}');
    }
  }

  Future<void> deleteStation(String id) async {
    try {
      await dioClient.delete(
        '/stations/$id',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
    } on DioError catch (e) {
      throw Exception('Failed to delete station: ${e.message}');
    }
  }
}
