class PngAssets {
  static String get gasStationMarker => 'gas_station'.png;

  const PngAssets._();
}

extension on String {
  String get png => 'assets/images/$this.png';
}
