import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class AppTheme {
  static TextDirection textDirection = TextDirection.ltr;
  static ThemeType themeType = ThemeType.light;
  static ThemeData theme = getTheme();
  static ThemeData get light {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide.none,
    );
    return ThemeData(
      primarySwatch: Colors.blue,
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        border: inputBorder,
        errorBorder: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        disabledBorder: inputBorder,
      ),
    );
  }

//dark theme
  static final ThemeData darkTheme = ThemeData(
    /// Brightness
    brightness: Brightness.dark,

    /// Primary Color
    primaryColor: const Color(0xff069DEF),

    /// Scaffold and Background color
    scaffoldBackgroundColor: const Color(0xff161616),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xff161616)),

    /// Card Theme
    cardTheme: const CardTheme(color: Color(0xff222327)),
    cardColor: const Color(0xff222327),

    /// Input (Text-Field) Theme
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff069DEF)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70),
      ),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
    ),

    /// Divider Color
    dividerTheme:
        const DividerThemeData(color: Color(0xff363636), thickness: 1),
    dividerColor: const Color(0xff363636),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xff069DEF),
        splashColor: Colors.white.withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: const Color(0xff069DEF),
        hoverColor: const Color(0xff069DEF),
        foregroundColor: Colors.white),

    /// Bottom AppBar Theme
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color(0xff464c52), elevation: 2),

    /// Tab bar Theme
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color(0xff495057),
      labelColor: Color(0xff069DEF),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xff069DEF), width: 2),
      ),
    ),

    ///Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith((state) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xffabb3ea);
        }
        return null;
      }),
      thumbColor: MaterialStateProperty.resolveWith((state) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xff3C4EC5);
        }
        return null;
      }),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xff069DEF),
      inactiveTrackColor: const Color(0xff069DEF).withAlpha(100),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4,
      thumbColor: const Color(0xff069DEF),
      thumbShape: const RoundSliderThumbShape(),
      overlayShape: const RoundSliderOverlayShape(),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
      ),
    ),

    ///Other Color
    indicatorColor: Colors.white,
    disabledColor: const Color(0xffa3a3a3),
    highlightColor: Colors.white.withAlpha(28),
    splashColor: Colors.white.withAlpha(56),
    colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff069DEF), brightness: Brightness.dark)
        .copyWith(background: const Color(0xff161616))
        .copyWith(error: Colors.orange),
  );

  static ThemeData getTheme([ThemeType? themeType]) {
    themeType = themeType ?? AppTheme.themeType;
    if (themeType == ThemeType.light) return light;
    return darkTheme;
  }

  const AppTheme._();
}
