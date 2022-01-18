import 'package:flutter/material.dart';

class UITheme {
  static ThemeData getLightTheme() {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      primaryColor: const Color(0xFF041956),
      backgroundColor: const Color(0xFFF9FBFF),
      highlightColor: const Color(0xFFD916E4),
      cardColor: Colors.white,
      colorScheme: baseTheme.colorScheme.copyWith(
        secondary: const Color(0xFF2D76EC),
        secondaryVariant: const Color(0xFF5F72A6),
        surface: const Color(0xFFB8C0D3),
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
      primaryColor: const Color(0xFF041956),
      backgroundColor: const Color(0xFF344FA1),
      highlightColor: const Color(0xFFD916E4),
      cardColor: const Color(0xFF041956),
      colorScheme: baseTheme.colorScheme.copyWith(
        secondary: const Color(0xFFD916E4),
        secondaryVariant: const Color(0xFF5F72A6),
        surface: const Color(0xFF173587),
      ),
      textTheme: baseTheme.textTheme.copyWith(
        bodyText2: baseTheme.textTheme.bodyText2?.copyWith(
          color: Colors.white,
          fontSize: 16,
        ),
        headline4: baseTheme.textTheme.headline6?.copyWith(color: Colors.white),
      ),
    );
  }
}
