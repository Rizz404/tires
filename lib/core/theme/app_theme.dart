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

  // * Additional colors for comprehensive theming
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);

  // * ThemeData Getter for Material Design (Light)
  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light(useMaterial3: true);

    return baseTheme.copyWith(
      brightness: Brightness.light,
      primaryColor: brand,
      scaffoldBackgroundColor: Colors.white,

      // * Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: brand,
        brightness: Brightness.light,
        primary: brand,
        secondary: mainButton,
        surface: Colors.white,
        onSurface: mainText,
        error: error,
        tertiary: brandSub,
        outline: Colors.grey.shade300,
        outlineVariant: Colors.grey.shade200,
      ),

      // * Text Theme
      textTheme: baseTheme.textTheme
          .copyWith(
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
            titleMedium: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: mainText,
            ),
            titleSmall: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: mainText,
            ),
            bodyLarge: const TextStyle(fontSize: 16, color: mainText),
            bodyMedium: const TextStyle(fontSize: 14, color: mainText),
            bodySmall: const TextStyle(fontSize: 12, color: mainText),
            labelLarge: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            labelMedium: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            labelSmall: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          )
          .apply(
            fontFamily: fontSans,
            bodyColor: mainText,
            displayColor: mainText,
          ),

      // * App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: brand,
        foregroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black26,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),

      // * Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: brand,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // * Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: brandSub,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: fontSans,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: brand,
            );
          }
          return const TextStyle(
            fontFamily: fontSans,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: brand);
          }
          return const IconThemeData(color: Colors.grey);
        }),
        elevation: 8,
        height: 80,
      ),

      // * Drawer Theme
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),

      // * List Tile Theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        textColor: mainText,
        iconColor: Colors.grey,
        selectedColor: brand,
        selectedTileColor: brandSub,
        titleTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: mainText,
        ),
        subtitleTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          color: Colors.grey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),

      // * Card Theme
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey.withValues(alpha: 0.2),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // * Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: mainButton,
          foregroundColor: Colors.white,
          disabledBackgroundColor: disabled,
          disabledForegroundColor: Colors.grey.shade600,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black26,
          elevation: 2,
          textStyle: const TextStyle(
            fontFamily: fontSans,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          minimumSize: const Size(88, 44),
        ),
      ),

      // * Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: brand,
          disabledForegroundColor: Colors.grey.shade600,
          side: const BorderSide(color: brand, width: 1),
          textStyle: const TextStyle(
            fontFamily: fontSans,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          minimumSize: const Size(88, 44),
        ),
      ),

      // * Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: link,
          disabledForegroundColor: Colors.grey.shade600,
          textStyle: const TextStyle(
            fontFamily: fontSans,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      // * Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: mainButton,
        foregroundColor: Colors.white,
        elevation: 6,
        focusElevation: 8,
        hoverElevation: 8,
        highlightElevation: 12,
        shape: CircleBorder(),
      ),

      // * Icon Button Theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: mainText,
          disabledForegroundColor: Colors.grey.shade400,
          highlightColor: brandSub,
          padding: const EdgeInsets.all(8),
        ),
      ),

      // * Input Decoration Theme
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: brand, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        hintStyle: TextStyle(fontFamily: fontSans, color: Colors.grey.shade500),
        labelStyle: const TextStyle(fontFamily: fontSans, color: mainText),
        errorStyle: const TextStyle(fontFamily: fontSans, color: error),
      ),

      // * Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return brand;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(color: Colors.grey, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // * Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return brand;
          }
          return Colors.grey;
        }),
      ),

      // * Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.grey.shade300;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return brand;
          }
          return Colors.grey.shade400;
        }),
      ),

      // * Slider Theme
      sliderTheme: const SliderThemeData(
        activeTrackColor: brand,
        inactiveTrackColor: disabled,
        thumbColor: brand,
        overlayColor: brandSub,
        valueIndicatorColor: brand,
        valueIndicatorTextStyle: TextStyle(
          fontFamily: fontSans,
          color: Colors.white,
        ),
      ),

      // * Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: brand,
        linearTrackColor: disabled,
        circularTrackColor: disabled,
      ),

      // * Tab Bar Theme
      tabBarTheme: const TabBarThemeData(
        labelColor: brand,
        unselectedLabelColor: Colors.grey,
        indicatorColor: brand,
        labelStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
      ),

      // * Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade100,
        disabledColor: disabled,
        selectedColor: brandSub,
        secondarySelectedColor: brand,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        labelStyle: const TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          color: mainText,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          color: Colors.white,
        ),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // * Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titleTextStyle: const TextStyle(
          fontFamily: fontSans,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: mainText,
        ),
        contentTextStyle: const TextStyle(
          fontFamily: fontSans,
          fontSize: 16,
          color: mainText,
        ),
      ),

      // * Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        modalElevation: 16,
        modalBackgroundColor: Colors.white,
      ),

      // * Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: mainText,
        contentTextStyle: const TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          color: Colors.white,
        ),
        actionTextColor: mainButton,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 6,
      ),

      // * Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: mainText,
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: const TextStyle(
          fontFamily: fontSans,
          fontSize: 12,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // * Popup Menu Theme
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          color: mainText,
        ),
      ),

      // * Divider Theme
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade300,
        thickness: 1,
        space: 16,
      ),

      // * Banner Theme
      bannerTheme: const MaterialBannerThemeData(
        backgroundColor: brandSub,
        contentTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          color: mainText,
        ),
        padding: EdgeInsets.all(16),
      ),

      // * Data Table Theme
      dataTableTheme: const DataTableThemeData(
        headingTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: mainText,
        ),
        dataTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          color: mainText,
        ),
        columnSpacing: 24,
        horizontalMargin: 16,
        dividerThickness: 1,
      ),

      // * Expansion Tile Theme
      expansionTileTheme: const ExpansionTileThemeData(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        textColor: mainText,
        collapsedTextColor: mainText,
        iconColor: Colors.grey,
        collapsedIconColor: Colors.grey,
        childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        expandedAlignment: Alignment.centerLeft,
      ),

      // * Search Bar Theme
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontFamily: fontSans, fontSize: 16, color: mainText),
        ),
        hintStyle: WidgetStateProperty.all(
          TextStyle(
            fontFamily: fontSans,
            fontSize: 16,
            color: Colors.grey.shade500,
          ),
        ),
      ),

      // * Segmented Button Theme
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: mainText,
          selectedForegroundColor: Colors.white,
          selectedBackgroundColor: brand,
          side: const BorderSide(color: brand, width: 1),
          textStyle: const TextStyle(
            fontFamily: fontSans,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
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
      primaryContrastingColor: Colors.white,

      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: fontSans, color: mainText),
        actionTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: brand,
        ),
        tabLabelTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
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
          color: Colors.white,
        ),
        pickerTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 18,
          color: mainText,
        ),
        dateTimePickerTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 18,
          color: mainText,
        ),
      ),
    );
  }

  // * Dark Theme (Optional)
  static ThemeData get darkTheme {
    final baseTheme = ThemeData.dark(useMaterial3: true);

    return baseTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: brand,
      scaffoldBackgroundColor: const Color(0xFF121212),

      colorScheme: ColorScheme.fromSeed(
        seedColor: brand,
        brightness: Brightness.dark,
        primary: brand,
        secondary: mainButton,
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white,
        error: error,
      ),

      // Add other dark theme configurations as needed
      textTheme: baseTheme.textTheme.apply(
        fontFamily: fontSans,
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(
          fontFamily: fontSans,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Add other dark theme component themes...
    );
  }
}
