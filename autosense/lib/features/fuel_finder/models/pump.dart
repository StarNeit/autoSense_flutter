class Pump {
  final String id;
  final String fuelType;
  final double price;
  final bool available;

  Pump({
    required this.id,
    required this.fuelType,
    required this.price,
    required this.available,
  });

  factory Pump.fromJson(Map<String, dynamic> json) {
    return Pump(
      id: json['_id'] ?? '',
      fuelType: json['fuel_type'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      available: json['available'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fuel_type': fuelType,
      'price': price,
      'available': available,
    };
  }

  Pump copyWith({
    String? id,
    String? fuelType,
    double? price,
    bool? available,
  }) {
    return Pump(
      id: id ?? this.id,
      fuelType: fuelType ?? this.fuelType,
      price: price ?? this.price,
      available: available ?? this.available,
    );
  }
}
