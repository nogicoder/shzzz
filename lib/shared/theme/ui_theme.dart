import 'package:flutter/material.dart';

class UITheme {
  static ThemeData getLightTheme() {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
        primaryColor: const Color(0xFF6867AC),
        colorScheme: baseTheme.colorScheme.copyWith(
          secondary: const Color(0xFFA267AC),
        ),
        textTheme: baseTheme.textTheme.copyWith(
          bodyText2: baseTheme.textTheme.bodyText2?.copyWith(
            color: const Color(0xFFFFBCD1),
            fontSize: 14,
          ),
          headline5: baseTheme.textTheme.headline5
              ?.copyWith(color: const Color(0xFFFFBCD1)),
        ));
  }

  static ThemeData getDarkTheme() {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF6867AC),
    );
  }
}
