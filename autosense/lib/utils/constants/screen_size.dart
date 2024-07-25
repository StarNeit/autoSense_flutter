import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceSize {
  //Default value to 1920x1080
  static late MediaQueryData _mediaQueryData;
  static double screenWidth = 1920;
  static double screenHeight = 1080;
  static double blockSizeHorizontal = 192;
  static double blockSizeVertical = 108;

  static double _safeAreaHorizontal = 0;
  static double _safeAreaVertical = 0;
  static double safeBlockHorizontal = 192;
  static double safeBlockVertical = 108;
  static double safeAreaTop = 1920;
  static double safeAreaBottom = 1080;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    safeAreaTop = _mediaQueryData.padding.top;
    safeAreaBottom = _mediaQueryData.padding.bottom;
  }

  static double getSafeWidth(double percentage) {
    return safeBlockHorizontal * percentage;
  }

  static double getSafeHeight(double percentage) {
    return safeBlockVertical * percentage;
  }

  static double getWidth(double percentage) {
    return blockSizeHorizontal * percentage;
  }

  static double getHeight(double percentage) {
    return blockSizeVertical * percentage;
  }

  static double getPaddingXS() {
    return safeBlockVertical * 1;
  }

  static double getPaddingS() {
    return safeBlockVertical * 2;
  }

  static double getPaddingM() {
    return safeBlockVertical * 4;
  }

  static double getPaddingL() {
    return safeBlockVertical * 8;
  }

  static double getTittleFontSize() {
    return screenHeight >= 812 ? 36 : 30;
  }

  static double getTextFontSize() {
    return screenHeight >= 812 ? 20 : 18;
  }

  static double getButtonFontSize() {
    return screenHeight >= 812 ? 16 : 14;
  }

  static bool isTablet() {
    return _mediaQueryData.size.width > 550;
  }

  static bool isWeb() {
    return kIsWeb;
  }
}
