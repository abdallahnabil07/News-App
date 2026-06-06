import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cubit responsible for managing app theme settings.
///
/// Handles:
/// - Loading saved theme from local storage
/// - Persisting theme changes
/// - Emitting current ThemeMode to UI
class SettingsCubit extends Cubit<ThemeMode> {
  SettingsCubit() : super(ThemeMode.system);

  /// Key used to store theme value in SharedPreferences
  static const String themeKey = "theme_mode";

  /// Loads saved theme from local storage and updates state
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saveTheme = prefs.getString(themeKey);

    switch (saveTheme) {
      case "light":
        emit(ThemeMode.light);
        break;

      case "dark":
        emit(ThemeMode.dark);
        break;

    /// Default fallback when no saved theme exists
      default:
        emit(ThemeMode.system);
    }
  }

  /// Changes app theme and saves it locally
  ///
  /// [newTheme] → selected theme mode from UI
  Future<void> changeTheme(ThemeMode newTheme) async {
    final prefs = await SharedPreferences.getInstance();

    if (newTheme == ThemeMode.light) {
      await prefs.setString(themeKey, "light");
    } else if (newTheme == ThemeMode.dark) {
      await prefs.setString(themeKey, "dark");
    } else {
      await prefs.setString(themeKey, "system");
    }

    emit(newTheme);
  }
}