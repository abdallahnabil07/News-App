import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<ThemeMode> {
  SettingsCubit() : super(ThemeMode.system);

  void changeTheme(ThemeMode newTheme) {
    emit(newTheme);
  }
}