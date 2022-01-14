import 'package:flutter/material.dart';

class UITheme {
  static ThemeData getLightTheme() {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      primaryColor: const Color(0xFF292663),
    );
  }

  static ThemeData getDarkTheme() {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF1A1E2D),
    );
  }
}
