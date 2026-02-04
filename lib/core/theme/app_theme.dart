import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static const isDark = true;
  static final textColorTitle = isDark
      ? AppColors.primaryColorLight
      : AppColors.blackColor;
  static ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.primaryColorLight,
    useMaterial3: true,
    primaryColor: AppColors.primaryColorLight,
    fontFamily: "inter",
    textTheme: TextTheme(
      titleLarge: TextStyle(
        //20
        fontWeight: FontWeight.w700,
        color: AppColors.primaryColorDark,
      ),
      titleMedium: TextStyle(
        //16
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.primaryColorDark,
        fontSize: 20,
      ),
    ),
  );
  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.primaryColorDark,
    useMaterial3: true,
    primaryColor: AppColors.primaryColorDark,
    fontFamily: "inter",
    textTheme: TextTheme(
      titleLarge: TextStyle(
        //20
        fontWeight: FontWeight.w700,
        color: AppColors.primaryColorLight,
      ),
      titleMedium: TextStyle(
        //16
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColorLight,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primaryColorLight,
      titleTextStyle: TextStyle(
        fontFamily: "inter",
        fontWeight: FontWeight.w400,
        color: textColorTitle,
        fontSize: 20,
      ),
    ),
  );
}
