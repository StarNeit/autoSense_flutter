class SvgAssets {
  static String get logoCircularFilled => 'logo_circular_filled'.svg;

  static String get logoCircularOutlined => 'logo_circular_outlined'.svg;

  static String get logoRectangularFilled => 'logo_rectangular_filled'.svg;

  static String get logoText => 'logo_text'.svg;

  static String get deleteCircle => 'delete_circle'.svg;

  static String get leaderLogo => 'leader_logo'.svg;

  const SvgAssets._();
}

extension on String {
  String get svg => 'assets/svgs/$this.svg';
}
