// import 'package:flutter/material.dart';
// import 'package:notes/const/colors.dart';

// class MyAppTheme {
//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.grey,
//     colorScheme: const ColorScheme.light(
//       primary: ColorClass.orginalWhite,
//       onPrimary: ColorClass.white,
//       secondary: ColorClass.orginalWhite,
//       onSecondary: ColorClass.orginalGrey,
//     ),
//     textTheme: const TextTheme(
//       titleMedium: TextStyle(
//         color: ColorClass.black,
//         fontFamily: "Courier",
//       ),
//       bodyMedium: TextStyle(
//         color: ColorClass.black,
//         fontFamily: "Courier",
//       ),
//       headlineMedium: TextStyle(
//         color: ColorClass.orginalGrey,
//         fontFamily: "Courier",
//       ),
//     ),
//     iconTheme: const IconThemeData(
//       color: ColorClass.white,
//     ),
//   );

//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primarySwatch: Colors.amber,
//     colorScheme: ColorScheme.dark(
//       primary: ColorClass.grey,
//       onPrimary: Colors.black,
//       secondary: ColorClass.white,
//       onSecondary: ColorClass.orginalGrey,
//     ),
//     textTheme: const TextTheme(
//       titleMedium: TextStyle(
//         color: ColorClass.white,
//       ),
//       bodyMedium: TextStyle(
//         color: Colors.white,
//       ),
//       headlineMedium: TextStyle(
//         color: Colors.grey,
//       ),
//     ),
//     iconTheme: const IconThemeData(
//       color: ColorClass.white,
//     ),
//     floatingActionButtonTheme: const FloatingActionButtonThemeData(
//       foregroundColor: ColorClass.white,
//     ),
//   );
// }
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
      primary: ColorClass.white,
      onPrimary: ColorClass.white,
      secondary: ColorClass.deepGreen,
      onSecondary: ColorClass.deepGreen,
      // ignore: deprecated_member_use
      background: ColorClass.lightTealAccent,
      surface: ColorClass.lightTeal,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: ColorClass.black,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: ColorClass.black,
        fontFamily: "Montserrat",
      ),
      headlineMedium: TextStyle(
        color: ColorClass.black,
        fontFamily: "Montserrat",
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
      primary: ColorClass.black,
      onPrimary: ColorClass.white,
      secondary: ColorClass.white,
      // ignore: deprecated_member_use
      background: ColorClass.darkGrey,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: ColorClass.white,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: ColorClass.white,
        fontFamily: "Montserrat",
      ),
      headlineMedium: TextStyle(
        color: ColorClass.amberAccent,
        fontFamily: "Montserrat",
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorClass.white,
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
