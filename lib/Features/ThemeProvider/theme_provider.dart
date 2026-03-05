import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;
}

class AppTheme {
  static final darkTheme = ThemeData(
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      toolbarTextStyle: appTextStyle.copyWith(
        color: Colors.white,
      ),
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.grey.shade900,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    cardColor: cardBackGroundColor,
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: cardBackGroundColor,
    ),
    hintColor: Colors.white,
    snackBarTheme: const SnackBarThemeData(actionTextColor: Colors.white),
    colorScheme: const ColorScheme.dark()
        .copyWith(background: Colors.black)
        .copyWith(background: Colors.black),
  );

  static final lightTheme = ThemeData(
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      toolbarTextStyle: appTextStyle.copyWith(
        color: Colors.black,
      ),
      foregroundColor: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    primaryColor: Colors.white,
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: appTextBoxColor,
    ),
    hintColor: appHintColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    snackBarTheme: const SnackBarThemeData(actionTextColor: Colors.white),
    colorScheme: const ColorScheme.light()
        .copyWith(background: Colors.white)
        .copyWith(background: Colors.white),
  );
}
