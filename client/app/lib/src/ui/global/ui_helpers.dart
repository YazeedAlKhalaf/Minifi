import 'package:flutter/material.dart';

class _SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    blockSizeHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    blockSizeVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

double screenWidth(BuildContext context) {
  _SizeConfig().init(context);
  return _SizeConfig.screenWidth;
}

double screenHeight(BuildContext context) {
  _SizeConfig().init(context);
  return _SizeConfig.screenHeight;
}

double blockSizeHorizontal(BuildContext context) {
  _SizeConfig().init(context);
  return _SizeConfig.blockSizeHorizontal;
}

double blockSizeVertical(BuildContext context) {
  _SizeConfig().init(context);
  return _SizeConfig.blockSizeVertical;
}
