import 'package:flutter/material.dart';

class UITheme {
  static ThemeData getLightTheme() {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      primaryColor: const Color(0xFF0B235E),
      backgroundColor: const Color(0xFFF9FBFF),
      colorScheme: baseTheme.colorScheme.copyWith(
        secondary: const Color(0xFF2D76EC),
        secondaryVariant: const Color(0xFF5F72A6),
        surface: const Color(0xFFb8c0d3),
      ),
      textTheme: baseTheme.textTheme.copyWith(
        bodyText2: baseTheme.textTheme.bodyText2?.copyWith(
          color: const Color(0xFF020417),
          fontSize: 16,
        ),
        headline4: baseTheme.textTheme.headline6
            ?.copyWith(color: const Color(0xFF373b5e)),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      primaryColor: const Color(0xFF0B235E),
      backgroundColor: const Color(0xFFF9FBFF),
      colorScheme: baseTheme.colorScheme.copyWith(
        secondary: const Color(0xFF2D76EC),
        surface: const Color(0xFFb8c0d3),
        //   background: const Color(0xFFFFBCD1),
      ),
      textTheme: baseTheme.textTheme.copyWith(
        bodyText2: baseTheme.textTheme.bodyText2?.copyWith(
          color: const Color(0xFF020417),
          fontSize: 16,
        ),
        headline4: baseTheme.textTheme.headline6
            ?.copyWith(color: const Color(0xFF373b5e)),
      ),
    );
  }
}
