import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    textTheme: GoogleFonts.interTextTheme(),
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
    textTheme: GoogleFonts.interTextTheme(),
    scaffoldBackgroundColor: AppColors.primaryColorDark,
    useMaterial3: true,
    primaryColor: AppColors.primaryColorDark,
    fontFamily: "inter",
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primaryColorLight,
      titleTextStyle: TextStyle(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontWeight: FontWeight.w400,
        color: textColorTitle,
        fontSize: 20,
      ),
    ),
  );
}
