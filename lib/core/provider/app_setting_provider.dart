import 'package:flutter/material.dart';

class AppSettingProvider extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.system;

  ThemeMode get currentTheme => _currentTheme;

  void changeTheme(ThemeMode newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }
}
