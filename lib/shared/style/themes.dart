
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marketing/shared/style/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Jannah',
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black
    )
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 5.0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black
    ),
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
    titleSpacing: 20.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 10.0,
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor
  ),
);