import 'package:flutter/material.dart';
import 'package:notes/const/colors.dart';

class MyAppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    colorScheme: const ColorScheme.light(
      primary: ColorClass.orginalWhite,
      onPrimary: ColorClass.white,
      secondary: ColorClass.orginalWhite,
      onSecondary: ColorClass.orginalGrey,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: ColorClass.black,
        fontFamily: "Courier",
      ),
      bodyMedium: TextStyle(
        color: ColorClass.black,
        fontFamily: "Courier",
      ),
      headlineMedium: TextStyle(
        color: ColorClass.orginalGrey,
        fontFamily: "Courier",
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorClass.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.amber,
    colorScheme: ColorScheme.dark(
      primary: ColorClass.grey,
      onPrimary: Colors.black,
      secondary: ColorClass.white,
      onSecondary: ColorClass.orginalGrey,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: ColorClass.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        color: Colors.grey,
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorClass.white,
    ),
    timePickerTheme: TimePickerThemeData(
      cancelButtonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          ColorClass.white,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: ColorClass.white,
          ),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: ColorClass.white,
    ),
  );
}
