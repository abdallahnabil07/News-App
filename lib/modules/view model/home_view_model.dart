import 'package:flutter/material.dart';
import 'package:news/model/api/articles_data_model.dart';
import 'package:news/model/api/source_data_model.dart';
import 'package:news/network%20handler/network_handler.dart';

import '../../model/category_data.dart';

class HomeViewModel extends ChangeNotifier {
  int _selectedTapIndex = 0;

  String _selectCountry = "Egypt";

  ThemeMode _selectTheme = ThemeMode.dark;

  bool isLoading = false;

  String? errorMessage;

  CategoryData? _selectedCategory;

  int page = 1;

  bool isLoadingMore = false;

  bool hasMore = true;

  int get currentIndex => _selectedTapIndex;

  String get selectCountry => _selectCountry;

  ThemeMode get selectTheme => _selectTheme;

  CategoryData? get selectedCategory => _selectedCategory;

  List<SourceData> _sourceData = [];

  List<SourceData> get sourceData => _sourceData;

  List<ArticlesDataModel> _articles = [];

  List<ArticlesDataModel> get articles => _articles;

  // get sources from NetworkHandel
  Future<void> getAllSources(String categoryId) async {
    try {
      isLoading = true;
      errorMessage = null;
      page = 1;
      hasMore = true;
      notifyListeners();
      _sourceData = await NetworkHandler.getAllSource(categoryId);
      if (_sourceData.isNotEmpty) {
        _selectedTapIndex = 0;
        await getAllArticles();
      }
    } catch (error) {
      errorMessage = ("Something went wrong");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // get articles from NetworkHandel
  Future<List<ArticlesDataModel>> getAllArticles({int page = 1}) async {
    if (sourceData.isEmpty) return [];
    try {
      if (page == 1) {
        isLoading = true;
        errorMessage = null;
        notifyListeners();
      }
      final response = await NetworkHandler.getNews(
        _sourceData[_selectedTapIndex].id,
        page: page,
      );
      if (page == 1) {
        _articles = response;
      } else {
        _articles.addAll(response);
      }
      return response;
    } catch (error) {
      errorMessage = ("Something went wrong");
      return [];
    } finally {
      if (page == 1) {
        isLoading = false;
      }
      notifyListeners();
    }
  }

  //refresh Articles
  Future<void> refresh() async {
    page = 1;
    hasMore = true;
    await getAllArticles(page: 1);
  }

  // Logic pagination
  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    final newArticle = await getAllArticles(page: page + 1);
    if (newArticle.isEmpty) {
      hasMore = false;
    } else {
      page++;
    }
    isLoadingMore = false;
    notifyListeners();
  }

  //Tap on sources
  void onTapChaneTapBar(int index) async {
    _selectedTapIndex = index;
    page = 1;
    hasMore = true;
    notifyListeners();
    await getAllArticles(page: 1);
  }

  //drawer(change country)
  void onTapChaneDrawerCountry(String value) async {
    _selectCountry = value;
    notifyListeners();
  }

  //drawer(change theme)
  void onTapChaneDrawerTheme(ThemeMode value) async {
    _selectTheme = value;
    notifyListeners();
  }

  //Tap on Category (sport,General,...etc)
  void onCategoryTap(CategoryData categoryModel) {
    _selectedCategory = categoryModel;
    notifyListeners();
  }

  //drawer back to Category list
  void goToHome(BuildContext context) {
    _selectedCategory = null;
    Navigator.pop(context);
    notifyListeners();
  }
}
