import 'package:flutter/material.dart';
import 'package:notes/core/const/colors.dart';
import 'package:notes/core/const/app_constants.dart';

class MyAppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorClass.warmCream,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorClass.warmCream,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorClass.charcoal),
      titleTextStyle: TextStyle(
        color: ColorClass.charcoal,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: const ColorScheme.light(
      surfaceDim: ColorClass.warmCream,
      surfaceContainerHighest: ColorClass.terracotta,
      onSurfaceVariant: ColorClass.softBeige,
      inversePrimary: ColorClass.charcoal,
      primary: ColorClass.warmCream,
      onPrimary: ColorClass.charcoal,
      secondary: ColorClass.terracotta,
      onSecondary: ColorClass.white,
      surface: ColorClass.softBeige,
    ),

//===================================================================================
//============================== DATE PICKER LIGHT ==================================
//===================================================================================

    datePickerTheme: DatePickerThemeData(
      backgroundColor: ColorClass.warmCream,
      dayBackgroundColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ColorClass.terracotta;
        }
        return null;
      }),
      dayForegroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ColorClass.white;
        }
        return ColorClass.charcoal;
      }),
      dayStyle: const TextStyle(
        color: ColorClass.charcoal,
        fontWeight: FontWeight.w500,
        fontFamily: AppConstants.fontFamily,
      ),
      dayOverlayColor: WidgetStateProperty.all(
        ColorClass.terracotta.withAlpha(50),
      ),
      todayForegroundColor: WidgetStateProperty.all(
        ColorClass.terracotta,
      ),
      todayBackgroundColor:
          WidgetStateProperty.all(ColorClass.terracotta.withAlpha(30)),
      yearForegroundColor: WidgetStateProperty.all(ColorClass.charcoal),
      yearBackgroundColor: WidgetStateProperty.all(ColorClass.warmCream),
      rangePickerBackgroundColor: ColorClass.warmCream,
      headerBackgroundColor: ColorClass.warmCream,
      headerForegroundColor: ColorClass.charcoal,
      dividerColor: ColorClass.warmSand,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      confirmButtonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          ColorClass.terracotta,
        ),
        foregroundColor: const WidgetStatePropertyAll(ColorClass.white),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          ColorClass.warmSand,
        ),
        foregroundColor: const WidgetStatePropertyAll(ColorClass.charcoal),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
//===================================================================================
//============================== TIME PICKER LIGHT ==================================
//===================================================================================
    timePickerTheme: TimePickerThemeData(
      backgroundColor: ColorClass.warmCream,
      dialTextColor: ColorClass.charcoal,
      hourMinuteTextColor: ColorClass.charcoal,
      dayPeriodTextColor: ColorClass.charcoal,
      dayPeriodColor: ColorClass.softBeige,
      dialHandColor: ColorClass.terracotta,
      dialBackgroundColor: ColorClass.softBeige,
      entryModeIconColor: ColorClass.terracotta,
      helpTextStyle:
          const TextStyle(color: ColorClass.charcoal, fontFamily: "Courier"),
      confirmButtonStyle: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          ColorClass.terracotta,
        ),
        foregroundColor: const WidgetStatePropertyAll(ColorClass.white),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          ColorClass.warmSand,
        ),
        foregroundColor: const WidgetStatePropertyAll(ColorClass.charcoal),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: ColorClass.charcoal,
        fontFamily: AppConstants.fontFamily,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: ColorClass.charcoal,
        fontFamily: AppConstants.fontFamily,
      ),
      headlineMedium: TextStyle(
        color: ColorClass.charcoal,
        fontFamily: AppConstants.fontFamily,
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorClass.charcoal,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorClass.terracotta,
      foregroundColor: ColorClass.white,
      elevation: 4,
      shape: CircleBorder(),
    ),
    cardTheme: CardThemeData(
      color: ColorClass.softBeige,
      shadowColor: ColorClass.warmBrown.withAlpha(30),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    dividerColor: ColorClass.warmSand,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorClass.terracotta,
      selectionColor: Color(0x40C97656),
      selectionHandleColor: ColorClass.terracotta,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorClass.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorClass.darkBackground,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorClass.white),
      titleTextStyle: TextStyle(
        color: ColorClass.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      surfaceDim: ColorClass.darkBackground,
      surfaceContainerHighest: ColorClass.darkSurface,
      onSurfaceVariant: ColorClass.darkSurface,
      inversePrimary: ColorClass.white,
      primary: ColorClass.darkBackground,
      onPrimary: ColorClass.white,
      secondary: ColorClass.darkAccent,
      onSecondary: ColorClass.darkBackground,
      surface: ColorClass.darkCard,
    ),
//===================================================================================
//=============================== DATE PICKER DARK ==================================
//===================================================================================
    datePickerTheme: DatePickerThemeData(
      backgroundColor: ColorClass.darkSurface,
      dayBackgroundColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ColorClass.darkAccent;
        }
        return null;
      }),
      dayForegroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ColorClass.darkBackground;
        }
        return ColorClass.white;
      }),
      todayForegroundColor: WidgetStateProperty.all(ColorClass.darkAccent),
      todayBackgroundColor:
          WidgetStateProperty.all(ColorClass.darkAccent.withAlpha(30)),
      headerBackgroundColor: ColorClass.darkSurface,
      headerForegroundColor: ColorClass.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      confirmButtonStyle: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          ColorClass.darkAccent,
        ),
        foregroundColor:
            const WidgetStatePropertyAll(ColorClass.darkBackground),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          ColorClass.darkCard,
        ),
        foregroundColor: const WidgetStatePropertyAll(ColorClass.white),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),

//===================================================================================
//=============================== TIME PICKER DARK ==================================
//===================================================================================
    timePickerTheme: TimePickerThemeData(
      backgroundColor: ColorClass.darkSurface,
      dialTextColor: ColorClass.white,
      hourMinuteTextColor: ColorClass.white,
      dayPeriodTextColor: ColorClass.darkBackground,
      dayPeriodColor: ColorClass.darkAccent,
      dialHandColor: ColorClass.darkAccent,
      dialBackgroundColor: ColorClass.darkCard,
      entryModeIconColor: ColorClass.darkAccent,
      helpTextStyle: const TextStyle(
        color: ColorClass.white,
        fontFamily: AppConstants.fontFamily,
      ),
      confirmButtonStyle: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          ColorClass.darkAccent,
        ),
        foregroundColor:
            const WidgetStatePropertyAll(ColorClass.darkBackground),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          ColorClass.darkCard,
        ),
        foregroundColor: const WidgetStatePropertyAll(ColorClass.white),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),

    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: ColorClass.white,
        fontFamily: AppConstants.fontFamily,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: ColorClass.white,
        fontFamily: AppConstants.fontFamily,
      ),
      headlineMedium: TextStyle(
        color: ColorClass.darkAccent,
        fontFamily: AppConstants.fontFamily,
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorClass.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorClass.darkAccent,
      foregroundColor: ColorClass.darkBackground,
      elevation: 4,
      shape: CircleBorder(),
    ),
    cardTheme: CardThemeData(
      color: ColorClass.darkCard,
      shadowColor: ColorClass.black.withAlpha(40),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    dividerColor: ColorClass.darkCard,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorClass.darkAccent,
      selectionColor: Color(0x40F5D547),
      selectionHandleColor: ColorClass.darkAccent,
    ),
  );
}
