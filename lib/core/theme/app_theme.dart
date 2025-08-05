import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // * Font Families from CSS
  static const String fontSans = 'InstrumentSans';
  static const String fontJP = 'NotoSansJP';
  static const String fontEN = 'NotoSans';

  // * Color Palette from CSS
  static const Color brand = Color(0xFF004080);
  static const Color brandSub = Color(0xFFE6F0FA);
  static const Color mainButton = Color(0xFFFF9900);
  static const Color mainButtonHover = Color(0xFFE68A00);
  static const Color mainText = Color(0xFF333333);
  static const Color link = Color(0xFF004080);
  static const Color linkHover = Color(0xFF002244);
  static const Color disabled = Color(0xFFE0E0E0);
  static const Color footerBg = Color(0xFF004080);
  static const Color footerText = Color(0xFFFFFFFF);

  // * ThemeData Getter for Material Design (Light)
  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light(useMaterial3: true);

    return baseTheme.copyWith(
      brightness: Brightness.light,
      primaryColor: brand,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: brand,
        brightness: Brightness.light,
        primary: brand,
        secondary: mainButton,
        surface: Colors.white,
        onSurface: mainText,
        error: Colors.red.shade700,
      ),
      textTheme: baseTheme.textTheme
          .copyWith(
            // Mapping from CSS text sizes
            headlineLarge: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: mainText,
            ),
            headlineMedium: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: mainText,
            ),
            headlineSmall: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: mainText,
            ),
            titleLarge: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: mainText,
            ),
            bodyLarge: const TextStyle(fontSize: 16, color: mainText),
            bodyMedium: const TextStyle(fontSize: 14, color: mainText),
            labelLarge: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            labelMedium: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
          .apply(
            fontFamily: fontSans,
            bodyColor: mainText,
            displayColor: mainText,
          ),
      appBarTheme: const AppBarTheme(
        backgroundColor: brand,
        foregroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black26,
        titleTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: mainButton,
          foregroundColor: Colors.white,
          disabledBackgroundColor: disabled,
          disabledForegroundColor: Colors.grey.shade600,
          textStyle: const TextStyle(
            fontFamily: fontSans,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: link,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: brand, width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey.shade500),
      ),
    );
  }

  // * CupertinoThemeData Getter for iOS
  static CupertinoThemeData get cupertinoTheme {
    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: brand,
      scaffoldBackgroundColor: Colors.white,
      barBackgroundColor: brand,
      primaryContrastingColor:
          Colors.white, // Color for text/icons on primaryColor
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: fontSans, color: mainText),
        navLargeTitleTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: mainText,
        ),
        navTitleTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: mainText,
        ),
        pickerTextStyle: TextStyle(fontFamily: fontSans, color: mainText),
        dateTimePickerTextStyle: TextStyle(
          fontFamily: fontSans,
          color: mainText,
        ),
      ),
    );
  }
}
