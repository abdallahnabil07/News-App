import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isLight => Theme.of(this).brightness == Brightness.light;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  // responsive height
  double hg(double n) {
    final h = MediaQuery.of(this).size.height;
    return n * (h / 880);
  }

  // responsive width
  double wd(double n) {
    final w = MediaQuery.of(this).size.width;
    return n * (w / 390);
  }

  double get paddingHeight4 => width * 0.0045;

  double get paddingHeight6 => width * 0.0068;

  double get paddingHeight8 => height * 0.009;

  double get paddingHeight10 => height * 0.011;

  double get paddingHeight12 => height * 0.014;

  double get paddingHeight14 => height * 0.016;

  double get paddingHeight16 => height * 0.018;

  double get paddingHeight18 => height * 0.020;

  double get paddingHeight20 => height * 0.023;

  double get paddingHeight22 => height * 0.025;

  double get paddingHeight24 => height * 0.027;

  double get paddingHeight26 => height * 0.029;

  double get paddingHeight28 => height * 0.031;

  double get paddingHeight30 => height * 0.034;

  double get paddingHeight32 => height * 0.036;

  double get paddingHeight34 => height * 0.038;

  double get paddingWidth4 => width * 0.010;

  double get paddingWidth6 => width * 0.015;

  double get paddingWidth8 => width * 0.021;

  double get paddingWidth10 => width * 0.026;

  double get paddingWidth12 => width * 0.031;

  double get paddingWidth14 => width * 0.036;

  double get paddingWidth16 => width * 0.041;

  double get paddingWidth18 => width * 0.046;

  double get paddingWidth20 => width * 0.051;

  double get paddingWidth22 => width * 0.056;

  double get paddingWidth24 => width * 0.061;

  double get paddingWidth26 => width * 0.066;

  double get paddingWidth28 => width * 0.071;

  double get paddingWidth30 => width * 0.076;

  double get paddingWidth32 => width * 0.082;

  double get paddingWidth34 => width * 0.087;

  double get paddingWidth36 => width * 0.092;

  // // responsive font size using textScaler
  // double fs(double fontSize, {double baseWidth = 390}) {
  //   final w = MediaQuery.of(this).size.width;
  //   final scaler = MediaQuery.textScalerOf(this);
  //
  //   // 1. احسب الحجم المتناسب مع عرض الشاشة
  //   final responsiveSize = fontSize * (w / baseWidth);
  //
  //   return scaler.scale(responsiveSize);
  // }

  // textTheme shortcut
  TextTheme get textTheme => Theme.of(this).textTheme;
}
