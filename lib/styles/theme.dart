import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var defaultColor = Colors.black;
var defaultDarkColor = Colors.white;
var defaultBlueColor = Color(0xff41729f)/*0xffeb7136*/;

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.lightBlue,
  scaffoldBackgroundColor: Colors.black,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: defaultDarkColor,
      backgroundColor: Colors.black,
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey),
  appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleSpacing: 20.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light),
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
          color: defaultDarkColor,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          fontFamily: "Jannah"),
      actionsIconTheme: IconThemeData(color: defaultDarkColor)),
  textTheme: const TextTheme(
      subtitle1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 1.3
      ),
      bodyText1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)),
  fontFamily: 'Jannah',
);

ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            height: 1.3
        ),
        bodyText2: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)),
    primarySwatch: Colors.lightBlue,
    floatingActionButtonTheme:
    FloatingActionButtonThemeData(backgroundColor: defaultBlueColor),
    scaffoldBackgroundColor: Color(0xffc3e0e5),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: defaultColor),
      titleSpacing: 20.0,
      titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          ),
      elevation: 0.0,
      backgroundColor: defaultBlueColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        size: 25
      ),
        unselectedIconTheme: IconThemeData(
          size: 25
        ),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: defaultBlueColor,
        elevation: 20.0,

    ),
    fontFamily: 'Jannah');
