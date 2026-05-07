part of 'home_cubit.dart';

class HomeState {
  final ThemeMode themeMode;
  final String country;
  final bool isSearching;
  final CategoryData?
  selectedCategory; // لو هتستخدم CategoryData خليها type صحيح

  const HomeState({
    required this.themeMode,
    required this.country,
    this.isSearching = false,
    this.selectedCategory,
  });

  HomeState copyWith({
    ThemeMode? themeMode,
    String? country,
    bool? isSearching,
    CategoryData? selectedCategory,
    bool clearCategory = false,
  }) {
    return HomeState(
      themeMode: themeMode ?? this.themeMode,
      country: country ?? this.country,
      isSearching: isSearching ?? this.isSearching,
      selectedCategory: clearCategory
          ? null
          : selectedCategory ?? this.selectedCategory,
    );
  }
}
