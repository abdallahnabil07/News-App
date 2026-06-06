/// Model representing a news category.
///
/// Used to define available categories in the application,
/// including display name and UI assets for light/dark modes.
class CategoryData {
  /// Unique identifier for the category (used in API requests)
  final String id;

  /// Display name of the category (Health ,Sports, Business)
  final String name;

  /// Image asset used in light mode UI
  final String imageLightMode;

  /// Image asset used in dark mode UI
  final String imageDarkMode;

  CategoryData({
    required this.name,
    required this.imageLightMode,
    required this.imageDarkMode,
    required this.id,
  });
}