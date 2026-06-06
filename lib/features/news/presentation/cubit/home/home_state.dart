part of 'home_cubit.dart';

/// Represents the state of the Home screen.
///
/// This state holds all UI-related data such as:
/// - Theme mode
/// - Selected country
/// - Search mode
/// - Selected category
/// - Articles list
/// - Loading and error states
class HomeState {
  /// Current app theme (light / dark / system)
  final ThemeMode themeMode;

  /// Selected country for news filtering (nullable = global/default)
  final String? country;

  /// Indicates whether search mode is active
  final bool isSearching;

  /// Currently selected news category (if any)
  final CategoryData? selectedCategory;

  static const _noValue = Object();

  /// List of currently displayed articles
  final List<ArticlesDataModel> articlesList;

  /// Indicates whether data is being loaded
  final bool isLoading;

  /// Error message to display in UI (if any)
  final String? errorMessage;

  const HomeState({
    required this.themeMode,
    required this.country,
    this.isSearching = false,
    this.selectedCategory,
    required this.articlesList,
    required this.isLoading,
    this.errorMessage,
  });

  /// Creates a new instance of HomeState with updated values
  ///
  /// Uses [_noValue] to differentiate between:
  /// - "not passed"
  /// - "explicit null (clear value)"
  HomeState copyWith({
    ThemeMode? themeMode,
    Object? country = _noValue,
    bool? isSearching,
    CategoryData? selectedCategory,
    bool clearCategory = false,
    List<ArticlesDataModel>? articlesList,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      themeMode: themeMode ?? this.themeMode,

      country: country == _noValue ? this.country : country as String?,

      isSearching: isSearching ?? this.isSearching,

      selectedCategory: clearCategory
          ? null
          : selectedCategory ?? this.selectedCategory,

      articlesList: articlesList ?? this.articlesList,

      isLoading: isLoading ?? this.isLoading,

      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
