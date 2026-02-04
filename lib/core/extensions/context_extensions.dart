import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isLight => Theme.of(this).brightness == Brightness.light;

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

  EdgeInsets get paddingAll4Height => EdgeInsets.all(paddingHeight4);

  EdgeInsets get paddingAll6Height => EdgeInsets.all(paddingHeight6);

  EdgeInsets get paddingAll8Height => EdgeInsets.all(paddingHeight8);

  EdgeInsets get paddingAll10Height => EdgeInsets.all(paddingHeight10);

  EdgeInsets get paddingAll12Height => EdgeInsets.all(paddingHeight12);

  EdgeInsets get paddingAll14Height => EdgeInsets.all(paddingHeight14);

  EdgeInsets get paddingAll16Height => EdgeInsets.all(paddingHeight16);

  EdgeInsets get paddingAll18Height => EdgeInsets.all(paddingHeight18);

  EdgeInsets get paddingAll20Height => EdgeInsets.all(paddingHeight20);

  EdgeInsets get paddingAll22Height => EdgeInsets.all(paddingHeight22);

  EdgeInsets get paddingAll24Height => EdgeInsets.all(paddingHeight24);

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

  EdgeInsets get paddingAll4Width => EdgeInsets.all(paddingWidth4);

  EdgeInsets get paddingAll6Width => EdgeInsets.all(paddingWidth6);

  EdgeInsets get paddingAll8Width => EdgeInsets.all(paddingWidth8);

  EdgeInsets get paddingAll10Width => EdgeInsets.all(paddingWidth10);

  EdgeInsets get paddingAll12Width => EdgeInsets.all(paddingWidth12);

  EdgeInsets get paddingAll14Width => EdgeInsets.all(paddingWidth14);

  EdgeInsets get paddingAll16Width => EdgeInsets.all(paddingWidth16);

  EdgeInsets get paddingAll18Width => EdgeInsets.all(paddingWidth18);

  EdgeInsets get paddingAll20Width => EdgeInsets.all(paddingWidth20);

  EdgeInsets get paddingAll22Width => EdgeInsets.all(paddingWidth22);

  EdgeInsets get paddingAll24Width => EdgeInsets.all(paddingWidth24);
}
