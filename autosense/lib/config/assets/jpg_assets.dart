class JpgAssets {
  static String get jpgTest => 'jpgTest'.jpg;
  const JpgAssets._();
}

extension on String {
  String get jpg => 'assets/images/$this.jpg';
}
