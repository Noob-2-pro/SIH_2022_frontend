import 'package:flutter/material.dart';

class SizeConfig {
  static late  MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;

  static late double safeAreaHorizontal;
  static late double safeAreaVertical;
  static late double safeBlockWidth;
  static late double safeBlockHeight;

  // iPhone 8
  static double constWidth = 3.75;
  static double constHeight = 6.47;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

    if (mediaQueryData.orientation == Orientation.portrait) {
      screenWidth = mediaQueryData.size.width;
      screenHeight = mediaQueryData.size.height;
    } else {
      screenWidth = mediaQueryData.size.height;
      screenHeight = mediaQueryData.size.width;
    }

    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;

    safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockWidth = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockHeight = (screenHeight - safeAreaVertical) / 100;
    //iPad Pro: 10.24, 13.16
    //iPad Air 2: 7.68, 10.04
    if (safeBlockWidth > 7.68) {
      safeBlockWidth = 7.68;
    }
    if (safeBlockHeight > 10.04) {
      safeBlockHeight = 10.04;
    }

    safeBlockWidth = safeBlockWidth / constWidth;
    safeBlockHeight = safeBlockHeight / constHeight;
  }
}
