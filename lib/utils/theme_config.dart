import 'package:flutter/material.dart';

class ThemeConfig {
  static Color lightPrimary = Color(0xFF1F2041);
  static Color lightAccent = Color(0xFF2D8F3F);
  static Color lightBG = Color(0xFFF0F0F0);

  static ThemeData theme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(elevation: 3.0),
  );
}
