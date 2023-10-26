import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recurring_alarm/theme/palette.dart';

class CustomTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Palette.primaryColor, onSurface: Palette.blackColor),
        scaffoldBackgroundColor: Palette.scaffoldColor,
        canvasColor: Palette.scaffoldColor,

        // * Time picker Theme
        timePickerTheme: const TimePickerThemeData(
          dialBackgroundColor: Colors.white,
          hourMinuteColor: Colors.white,
          elevation: 0,
          backgroundColor: Palette.scaffoldColor,
        ),
        // * Dialog Theme
        dialogTheme: const DialogTheme(
          elevation: 0,
          backgroundColor: Palette.scaffoldColor,
        ),

        // * Appbar Theme
        appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.transparent),

        // * Date picker Theme
        datePickerTheme: const DatePickerThemeData(
            elevation: 0,
            backgroundColor: Palette.scaffoldColor,
            headerBackgroundColor: Colors.white),

        // * Card Theme
        cardTheme: const CardTheme(elevation: 0),

        // * Bottom sheet Theme
        bottomSheetTheme: const BottomSheetThemeData(
            modalBackgroundColor: Palette.scaffoldColor,
            surfaceTintColor: Palette.scaffoldColor,
            backgroundColor: Palette.scaffoldColor),

        // * Floating action button Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Palette.primaryColor,
        ),

        // * Elevated button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                textStyle: const TextStyle())));
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
        dialogBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        segmentedButtonTheme: SegmentedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Palette.primaryColor.withOpacity(0.40);
                  }
                  return Palette.blackColor;
                }),
                foregroundColor: const MaterialStatePropertyAll(Colors.white))),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Palette.primaryColor,
          onSurface: Palette.scaffoldColor,
        ),
        scaffoldBackgroundColor: Palette.blackColor,
        canvasColor: Palette.scaffoldColor,

        // * Time picker Theme
        timePickerTheme: const TimePickerThemeData(
          dialTextColor: Palette.scaffoldColor,
          entryModeIconColor: Palette.scaffoldColor,
          dayPeriodTextColor: Palette.scaffoldColor,
          hourMinuteTextColor: Palette.scaffoldColor,
          dialBackgroundColor: Palette.blackColor,
          hourMinuteColor: Palette.blackColor,
          elevation: 1,
          backgroundColor: Palette.blackColor,
        ),

        // * Dialog Theme
        dialogTheme: const DialogTheme(
          elevation: 0,
          backgroundColor: Palette.blackColor,
        ),

        // * Appbar Theme
        appBarTheme: const AppBarTheme(
            foregroundColor: Palette.scaffoldColor,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.transparent),

        // * Date picker
        datePickerTheme: const DatePickerThemeData(
            headerForegroundColor: Palette.scaffoldColor,
            elevation: 1,
            dayForegroundColor: MaterialStatePropertyAll(Palette.scaffoldColor),
            backgroundColor: Palette.blackColor,
            headerBackgroundColor: Palette.blackColor),

        // * Card Theme
        cardTheme: const CardTheme(elevation: 0.5, color: Palette.blackColor),

        // * Bottom sheet Theme
        bottomSheetTheme: const BottomSheetThemeData(
            modalBackgroundColor: Palette.blackColor,
            surfaceTintColor: Palette.blackColor,
            backgroundColor: Palette.blackColor),

        // * Floating action button Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Palette.primaryColor,
        ),

        // * Elevated button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                textStyle: const TextStyle())));
  }
}
