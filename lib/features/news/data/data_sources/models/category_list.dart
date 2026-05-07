import 'package:news/core/gen/assets.gen.dart';
import 'package:news/features/news/data/data_sources/models/category_data.dart';

abstract class CategoryList {
  static List<CategoryData> categories = [
    //general
    CategoryData(
      id: 'general',
      name: 'General',
      imageLightMode: Assets.images.generalDark.path,
      imageDarkMode: Assets.images.general.path,
    ),
    //business
    CategoryData(
      id: 'business',
      name: 'Business',
      imageLightMode: Assets.images.busniessDark.path,
      imageDarkMode: Assets.images.busniess.path,
    ),
    //sports
    CategoryData(
      id: 'sports',
      name: 'Sports',
      imageLightMode: Assets.images.sportDark.path,
      imageDarkMode: Assets.images.sport.path,
    ),
    //health
    CategoryData(
      id: 'health',
      name: 'Health',
      imageLightMode: Assets.images.helthDark.path,
      imageDarkMode: Assets.images.helth.path,
    ),
    //entertainment
    CategoryData(
      id: 'entertainment',
      name: 'Entertainment',
      imageLightMode: Assets.images.entertainmentDark.path,
      imageDarkMode: Assets.images.entertainment.path,
    ),
    // technology
    CategoryData(
      id: 'technology',
      name: 'Technology',
      imageLightMode: Assets.images.technologyDark.path,
      imageDarkMode: Assets.images.technology.path,
    ),
    //science
    CategoryData(
      id: 'science',
      name: 'Science',
      imageLightMode: Assets.images.scienceDark.path,
      imageDarkMode: Assets.images.science.path,
    ),
  ];
}
