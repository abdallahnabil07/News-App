import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news/model/category_data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
    : super(
        const HomeState(
          themeMode: ThemeMode.system,
          country: "Egypt",
          isSearching: false,
          selectedCategory: null,
        ),
      );

  // Theme
  void changeTheme(ThemeMode value) {
    emit(state.copyWith(themeMode: value));
  }

  // Country
  void changeCountry(String value) {
    emit(state.copyWith(country: value));
  }

  // Search
  void toggleSearch() {
    emit(state.copyWith(isSearching: !state.isSearching));
  }

  void onSearchTextChange(String text) {
    // لو هتعمل فلترة على الأخبار
  }

  void clearSearch(TextEditingController controller) {
    controller.clear();
    emit(state.copyWith(isSearching: false));
  }

  // Category
  void selectCategory(dynamic category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void goHome() {
    emit(state.copyWith(clearCategory: true));
  }
}
