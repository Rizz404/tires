import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  String toMap() {
    return toString().split(".").last;
  }

  static ThemeMode fromMap(String themeMode) {
    return ThemeMode.values.firstWhere(
      (e) => e.toString().split(".").last == themeMode,
      orElse: () => ThemeMode.system,
    );
  }

  // ThemeData getThemeData(BuildContext context) {
  //   switch (this) {
  //     case ThemeMode.light:
  //       return AppTheme.lightTheme;
  //     case ThemeMode.dark:
  //       return AppTheme.darkTheme;
  //     case ThemeMode.system:
  //       final brightness = MediaQuery.platformBrightnessOf(context);
  //       return brightness == Brightness.dark
  //           ? AppTheme.darkTheme
  //           : AppTheme.lightTheme;
  //   }
  // }
}

extension ThemeExtensions on BuildContext {
  // * Extension yang sudah ada
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // * Akses ke tema input
  // InputDecorationTheme get inputTheme => Theme.of(this).inputDecorationTheme;

  // * Akses ke tema card
  CardThemeData get cardTheme => Theme.of(this).cardTheme;

  // * Akses ke tema tombol
  ButtonThemeData get buttonTheme => Theme.of(this).buttonTheme;
  ElevatedButtonThemeData get elevatedButtonTheme =>
      Theme.of(this).elevatedButtonTheme;

  // * Helper untuk mengecek tema gelap/terang
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
