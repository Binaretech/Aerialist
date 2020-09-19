import 'package:flutter/material.dart';

enum AppTheme { Light, Dark }

final appThemes = {
  AppTheme.Light: ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  AppTheme.Dark: ThemeData.dark(),
};
