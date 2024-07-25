import 'pump.dart';

class Station {
  final String id;
  final String name;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final List<Pump> pumps;

  Station({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.pumps,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    var list = json['pumps'] as List? ?? [];
    List<Pump> pumpsList = list.map((i) => Pump.fromJson(i)).toList();

    return Station(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      pumps: pumpsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'pumps': pumps.map((pump) => pump.toJson()).toList(),
    };
  }
}
