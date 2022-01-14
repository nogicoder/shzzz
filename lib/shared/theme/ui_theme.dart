import 'package:flutter/material.dart';

class UITheme {
  static ThemeData getLightTheme() {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      // primaryColor: const Color(0xFF020417),
      // backgroundColor: const Color(0xFF020417),
      // colorScheme: baseTheme.colorScheme.copyWith(
      //   secondary: const Color(0xFFA267AC),
      //   surface: const Color(0xFFCE7BB0),
      //   background: const Color(0xFFFFBCD1),
      // ),
      textTheme: baseTheme.textTheme.copyWith(
        bodyText2: baseTheme.textTheme.bodyText2?.copyWith(
          color: const Color(0xFF020417),
          fontSize: 14,
        ),
        headline4: baseTheme.textTheme.headline6
            ?.copyWith(color: const Color(0xFF373b5e)),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF6867AC),
    );
  }
}
