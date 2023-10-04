import 'package:flutter/material.dart';
import 'package:recurring_alarm/theme/palette.dart';

class CustomTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Palette.primaryColor),
        scaffoldBackgroundColor: Palette.scaffoldColor,
        canvasColor: Palette.scaffoldColor,
        timePickerTheme: const TimePickerThemeData(
          dialBackgroundColor: Colors.white,
          hourMinuteColor: Colors.white,
          elevation: 0,
          backgroundColor: Palette.scaffoldColor,
        ),
        dialogTheme: const DialogTheme(
          elevation: 0,
          backgroundColor: Palette.scaffoldColor,
        ),
        datePickerTheme: const DatePickerThemeData(
            elevation: 0,
            backgroundColor: Palette.scaffoldColor,
            headerBackgroundColor: Colors.white),
        cardTheme: const CardTheme(elevation: 0),
        bottomSheetTheme: const BottomSheetThemeData(
            modalBackgroundColor: Palette.scaffoldColor,
            surfaceTintColor: Palette.scaffoldColor,
            backgroundColor: Palette.scaffoldColor),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Palette.primaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                textStyle: const TextStyle())));
  }
}
