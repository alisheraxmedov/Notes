import 'package:flutter/material.dart';
import 'package:notes/const/colors.dart';

class MyAppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorClass.white,
    appBarTheme: const AppBarTheme(
      color: ColorClass.deepGreen2,
      iconTheme: IconThemeData(color: ColorClass.white),
      titleTextStyle: TextStyle(
        color: ColorClass.deepGreen,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: const ColorScheme.light(
      surfaceVariant: ColorClass.deepGreen,
      onSurfaceVariant: ColorClass.deepGreen3,
      inversePrimary: ColorClass.white,
      primary: ColorClass.white,
      onPrimary: ColorClass.white,
      secondary: ColorClass.deepGreen,
      onSecondary: ColorClass.deepGreen,
      // ignore: deprecated_member_use
      background: ColorClass.lightTealAccent,
      surface: ColorClass.lightTeal,
    ),

//===================================================================================
//============================== DATE PICKER LIGHT ==================================
//===================================================================================
    // datePickerTheme: const DatePickerThemeData(
    //   backgroundColor: ColorClass.deepGreen3,
    //   dividerColor: ColorClass.deepGreen,
    //   dayOverlayColor: WidgetStatePropertyAll(
    //     ColorClass.deepGreen,
    //   ),

    //   dayShape: WidgetStatePropertyAll(
    //     RoundedRectangleBorder(),
    //   ),
    //   todayBackgroundColor: WidgetStatePropertyAll(
    //     ColorClass.deepGreen,
    //   ),
    //   rangePickerBackgroundColor: ColorClass.deepGreen,
    // confirmButtonStyle: ButtonStyle(
    //   backgroundColor: WidgetStatePropertyAll(
    //     ColorClass.deepGreen,
    //   ),
    //   textStyle: WidgetStatePropertyAll(
    //     TextStyle(
    //       fontFamily: "Courier",
    //       color: ColorClass.white,
    //     ),
    //   ),
    //   shape: WidgetStatePropertyAll(
    //     RoundedRectangleBorder(),
    //   ),
    // ),
    // cancelButtonStyle: ButtonStyle(
    //   backgroundColor: WidgetStatePropertyAll(
    //     ColorClass.red,
    //   ),
    //   textStyle: WidgetStatePropertyAll(
    //     TextStyle(
    //       fontFamily: "Courier",
    //       color: ColorClass.white,
    //     ),
    //   ),
    //   shape: WidgetStatePropertyAll(
    //     RoundedRectangleBorder(),
    //   ),
    // ),
    // ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: ColorClass.deepGreen3, // Fonga rang
      dayBackgroundColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ColorClass.white; 
        }
        return null; 
      }),
      dayForegroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ColorClass.deepGreen; 
        }
        return ColorClass.white; // Oddiy kun matn rangi
      }),
      dayStyle: const TextStyle(
        color: ColorClass.white,
        fontWeight: FontWeight.bold,
        fontFamily: "Courier",
      ),
      dayOverlayColor: WidgetStateProperty.all(
          ColorClass.deepGreen), // Kunni belgilash uchun overlay rangi
          
      todayForegroundColor:
          WidgetStateProperty.all(ColorClass.white, ), // Bugungi kun matni rangi
      todayBackgroundColor:
          WidgetStateProperty.all(ColorClass.deepGreen), // Bugungi kun foni
      yearForegroundColor:
          WidgetStateProperty.all(ColorClass.white), // Yil matni rangi
      yearBackgroundColor:
          WidgetStateProperty.all(ColorClass.deepGreen3), // Yil fon rangi
      rangePickerBackgroundColor: ColorClass.deepGreen3, // Oraliq tanlash foni
      headerBackgroundColor: ColorClass.deepGreen3, // Sarlavha foni
      headerForegroundColor: ColorClass.white, // Sarlavha matni
      dividerColor: ColorClass.white, // Ajratgichning rangi
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ), // Rounded dizayn
      confirmButtonStyle: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          ColorClass.deepGreen,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: "Courier",
            color: ColorClass.white,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(),
        ),
      ),
      cancelButtonStyle: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          ColorClass.red,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: "Courier",
            color: ColorClass.white,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(),
        ),
      ),
    ),
//===================================================================================
//============================== TIME PICKER LIGHT ==================================
//===================================================================================
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: ColorClass.deepGreen3,
      dialTextColor: ColorClass.white,
      hourMinuteTextColor: ColorClass.deepGreen,
      dayPeriodTextColor: ColorClass.deepGreen,
      dayPeriodColor: ColorClass.white,
      dialHandColor: ColorClass.deepGreen3,
      dialBackgroundColor: ColorClass.deepGreen,
      entryModeIconColor: ColorClass.white,
      helpTextStyle: TextStyle(color: ColorClass.white, fontFamily: "Courier"),

      confirmButtonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          ColorClass.deepGreen,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: "Courier",
            color: ColorClass.white,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          ColorClass.red,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: "Courier",
            color: ColorClass.white,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(),
        ),
      ),
      // timeSelectorSeparatorColor: WidgetStatePropertyAll(
      //   ColorClass.white,
      // ),
      // hourMinuteColor: ColorClass.deepGreen3,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: ColorClass.black,
        fontFamily: "Courier",
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: ColorClass.black,
        fontFamily: "Courier",
      ),
      headlineMedium: TextStyle(
        color: ColorClass.black,
        fontFamily: "Courier",
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorClass.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorClass.teal,
      foregroundColor: ColorClass.white,
      elevation: 6,
    ),
    cardTheme: const CardTheme(
      color: ColorClass.lightTealAccent,
      shadowColor: ColorClass.tealDark,
      elevation: 4,
    ),
    dividerColor: ColorClass.white,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorClass.black,
    appBarTheme: const AppBarTheme(
      color: ColorClass.darkGrey,
      iconTheme: IconThemeData(color: ColorClass.white),
      titleTextStyle: TextStyle(
        color: ColorClass.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      surfaceVariant: ColorClass.darkGrey,
      onSurfaceVariant: ColorClass.darkGrey,
      inversePrimary: ColorClass.white,
      primary: ColorClass.black,
      onPrimary: ColorClass.white,
      secondary: ColorClass.white,
      onSecondary: ColorClass.white,
      // ignore: deprecated_member_use
      background: ColorClass.darkGrey,
    ),
//===================================================================================
//=============================== TIME PICKER DARK ==================================
//===================================================================================
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: ColorClass.darkGrey,
      dialTextColor: ColorClass.white,
      hourMinuteTextColor: ColorClass.white,
      dayPeriodTextColor: ColorClass.black,
      dayPeriodColor: ColorClass.white,
      dialHandColor: ColorClass.darkGrey,
      dialBackgroundColor: ColorClass.black,
      entryModeIconColor: ColorClass.black,
      helpTextStyle: TextStyle(
        color: ColorClass.white,
      ),
      confirmButtonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          ColorClass.grey,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: "Courier",
            color: ColorClass.white,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          ColorClass.red,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: "Courier",
            color: ColorClass.white,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(),
        ),
      ),
    ),

    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: ColorClass.white,
        fontFamily: "Courier",
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: ColorClass.white,
        fontFamily: "Courier",
      ),
      headlineMedium: TextStyle(
        color: ColorClass.amberAccent,
        fontFamily: "Courier",
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorClass.black,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorClass.darkGrey,
      foregroundColor: ColorClass.white,
      elevation: 6,
    ),
    cardTheme: const CardTheme(
      shadowColor: ColorClass.black,
      elevation: 4,
    ),
    dividerColor: ColorClass.grey,
  );
}
