import 'package:chat_me/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
      primaryColor: DARK_BLUE_COLOR,
      accentColor: WHITE_COLOR,
      scaffoldBackgroundColor: DARK_WHITE_COLOR,
      fontFamily: "cairo",
      iconTheme: IconThemeData(
        color: DARK_BLUE_COLOR,
        size: 25,     
      ),
     
      textTheme: TextTheme(
        button: TextStyle(
          color: WHITE_COLOR,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        caption: TextStyle(
          color: WHITE_COLOR,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        headline1: TextStyle(
          color: BLACK_COLOR,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        headline2: TextStyle(
          color: DARK_BLUE_COLOR,
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: TextStyle(
          color:GRAY_COLOR,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity);
}
