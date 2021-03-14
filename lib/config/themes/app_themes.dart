import 'package:flutter/material.dart';

enum AppTheme { Light, Dark }

final appThemes = {
  AppTheme.Light: ThemeData(
    primaryColor: Colors.white,
    accentColor: Color(0xFF2F80ED),
    iconTheme: IconThemeData(
      color: Color(0xFF979797),
    ),
    primaryTextTheme: TextTheme(
      headline6: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
    ),
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  AppTheme.Dark: ThemeData.dark(),
};
