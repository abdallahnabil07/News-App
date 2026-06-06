import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/network/network%20handler/network_exception.dart';
import 'package:news/core/services/notification_service.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:news/features/news/data/data_sources/models/category_data.dart';
import 'package:news/core/network/network%20handler/network_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

/// HomeCubit is responsible for managing the main application state.
///
/// Responsibilities:
/// - Managing theme mode
/// - Managing selected country
/// - Loading news by country or category
/// - Handling search functionality
/// - Managing selected category state
class HomeCubit extends Cubit<HomeState> {
  /// Key used to persist selected country in SharedPreferences
  static const String _countryKey = AppStrings.selectCountry;

  HomeCubit()
    : super(
        const HomeState(
          themeMode: ThemeMode.system,
          country: null,
          isSearching: false,
          selectedCategory: null,
          articlesList: [],
          isLoading: false,
          errorMessage: null,
        ),
      );

  /// Cache of all loaded articles (used for search filtering)
  List<ArticlesDataModel> _allArticles = [];

  // ====================== INIT ======================

  /// Initializes app state:
  /// - Loads saved country
  /// - Subscribes to notifications
  /// - Fetches initial news
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    final savedCountry = prefs.getString(_countryKey);

    emit(state.copyWith(country: savedCountry));

    await NotificationService.subscribeToCountry(savedCountry);

    await getNewsByCountry();
  }

  // ====================== THEME ======================

  /// Updates app theme mode (light/dark/system)
  void changeTheme(ThemeMode value) {
    emit(state.copyWith(themeMode: value));
  }

  // ====================== COUNTRY ======================

  /// Changes selected country and reloads news accordingly
  Future<void> changeCountry(String? value) async {
    final prefs = await SharedPreferences.getInstance();

    // Persist or remove country selection
    if (value == null) {
      await prefs.remove(_countryKey);
    } else {
      await prefs.setString(_countryKey, value);
    }

    EasyLoading.show(status: AppStrings.updatingNews);

    final hadCategory = state.selectedCategory;

    emit(
      state.copyWith(
        country: value,
        selectedCategory: null,
        clearCategory: true,
      ),
    );

    try {
      // Update notification subscription
      await NotificationService.subscribeToCountry(value);

      // Reload news based on previous context
      if (hadCategory != null) {
        await _fetchNewsForSelectedCategory();
      } else {
        await getNewsByCountry();
      }

      EasyLoading.showSuccess(AppStrings.updatingNews);
    } catch (e) {
      // Handle network errors
      if (e is NetworkException) {
        emit(state.copyWith(errorMessage: e.message));
        EasyLoading.showError(e.message);
      } else {
        emit(state.copyWith(errorMessage: AppStrings.somethingWentWrong));
        EasyLoading.showError(AppStrings.somethingWentWrong);
      }
    }
  }

  // ====================== SEARCH ======================

  /// Toggles search mode on/off
  void toggleSearch() {
    emit(state.copyWith(isSearching: !state.isSearching));
  }

  /// Filters articles based on search input
  void onSearch(String text) {
    if (text.isEmpty) {
      emit(state.copyWith(articlesList: _allArticles));
    } else {
      final filtered = _allArticles
          .where(
            (article) =>
                article.title.toLowerCase().contains(text.toLowerCase()),
          )
          .toList();

      emit(state.copyWith(articlesList: filtered));
    }
  }

  // ====================== CATEGORY ======================

  /// Selects a category and loads related news
  void selectCategory(CategoryData category) {
    emit(state.copyWith(selectedCategory: category));
    _fetchNewsForSelectedCategory();
  }

  /// Resets view back to home state (all news)
  void goHome() {
    emit(state.copyWith(clearCategory: true, articlesList: _allArticles));
  }

  // ====================== DATA LOADING ======================

  /// Fetches general news based on selected country
  Future<void> getNewsByCountry() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final news = await NetworkHandler.getNewsByCountry(state.country);

      _allArticles = news;

      emit(state.copyWith(articlesList: news, isLoading: false));
    } catch (e) {
      if (e is NetworkException) {
        emit(state.copyWith(isLoading: false, errorMessage: e.message));
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: AppStrings.somethingWentWrong,
          ),
        );
      }
      rethrow;
    }
  }

  /// Fetches news for selected category + country
  Future<void> _fetchNewsForSelectedCategory() async {
    if (state.selectedCategory == null) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final news = await NetworkHandler.getNewsByCategoryAndCountry(
        categoryId: state.selectedCategory!.id,
        country: state.country,
      );

      _allArticles = news;

      emit(state.copyWith(articlesList: news, isLoading: false));
    } catch (e) {
      if (e is NetworkException) {
        emit(state.copyWith(isLoading: false, errorMessage: e.message));
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: AppStrings.somethingWentWrong,
          ),
        );
      }
      rethrow;
    }
  }
}
