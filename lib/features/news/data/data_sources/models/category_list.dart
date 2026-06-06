import 'package:news/core/gen/assets.gen.dart';
import 'package:news/features/news/data/data_sources/models/category_data.dart';

/// Static list of available news categories.
///
/// This acts as a local data source for categories used in the app UI.
/// Each category contains:
/// - id for API filtering
/// - display name
/// - light/dark mode images for UI consistency
abstract class CategoryList {
  /// Predefined list of news categories displayed in home screen
  static List<CategoryData> categories = [
    // General news category
    CategoryData(
      id: 'general',
      name: 'General',
      imageLightMode: Assets.images.generalDark.path,
      imageDarkMode: Assets.images.general.path,
    ),

    // Business news category
    CategoryData(
      id: 'business',
      name: 'Business',
      imageLightMode: Assets.images.busniessDark.path,
      imageDarkMode: Assets.images.busniess.path,
    ),

    // Sports news category
    CategoryData(
      id: 'sports',
      name: 'Sports',
      imageLightMode: Assets.images.sportDark.path,
      imageDarkMode: Assets.images.sport.path,
    ),

    // Health news category
    CategoryData(
      id: 'health',
      name: 'Health',
      imageLightMode: Assets.images.helthDark.path,
      imageDarkMode: Assets.images.helth.path,
    ),

    // Entertainment news category
    CategoryData(
      id: 'entertainment',
      name: 'Entertainment',
      imageLightMode: Assets.images.entertainmentDark.path,
      imageDarkMode: Assets.images.entertainment.path,
    ),

    // Technology news category
    CategoryData(
      id: 'technology',
      name: 'Technology',
      imageLightMode: Assets.images.technologyDark.path,
      imageDarkMode: Assets.images.technology.path,
    ),

    // Science news category
    CategoryData(
      id: 'science',
      name: 'Science',
      imageLightMode: Assets.images.scienceDark.path,
      imageDarkMode: Assets.images.science.path,
    ),
  ];
}