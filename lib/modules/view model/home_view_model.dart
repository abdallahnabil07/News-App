import 'package:flutter/material.dart';
import 'package:news/model/api/articles_data_model.dart';
import 'package:news/model/api/source_data_model.dart';
import 'package:news/network%20handler/network_handler.dart';

import '../../model/category_data.dart';

class HomeViewModel extends ChangeNotifier {
  ////// ================= SEARCH LOGIC ================= //////

  bool _isSearching = false;
  String _searchQuery = "";
  List<ArticlesDataModel> _filterArticles = [];

  bool get isSearching => _isSearching;

  String get searchQuery => _searchQuery;

  List<ArticlesDataModel> get filterArticles => _filterArticles;

  List<ArticlesDataModel> get articlesShow =>
      _isSearching ? _filterArticles : _articles;

  // close search
  void onTapXIconSearching(TextEditingController searchController) {
    _isSearching = false;
    _searchQuery = "";
    _filterArticles = [];
    searchController.clear();
    notifyListeners();
  }

  // tap search icon
  void onTapIconSearching() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

  // start search
  void startSearching() {
    _isSearching = true;
    _filterArticles = _articles;
    notifyListeners();
  }

  // search logic
  void onSearchTextChange(String text) {
    _searchQuery = text;
    if (text.isEmpty) {
      _filterArticles = articles;
      hasMore = true;
    } else {
      _filterArticles = articles
          .where(
            (articles) =>
                articles.title.toLowerCase().contains(text.toLowerCase()),
          )
          .toList();
      hasMore = _filterArticles.length >= 3;
    }
    notifyListeners();
  }

  ////// ================= UI STATE ================= //////

  int _selectedTapIndex = 0;
  String _selectCountry = "Egypt";
  ThemeMode _selectTheme = ThemeMode.dark;
  CategoryData? _selectedCategory;

  int get currentIndex => _selectedTapIndex;
  String get selectCountry => _selectCountry;
  ThemeMode get selectTheme => _selectTheme;
  CategoryData? get selectedCategory => _selectedCategory;

  ////// ================= DATA ================= //////

  List<SourceData> _sourceData = [];
  List<ArticlesDataModel> _articles = [];

  List<SourceData> get sourceData => _sourceData;
  List<ArticlesDataModel> get articles => _articles;

  ////// ================= LOADING & PAGINATION ================= //////

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = true;

  String? errorMessage;

  int page = 1;

  ////// ================= NETWORK ================= //////

  // get sources
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

  // get articles
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

  ////// ================= PAGINATION ================= //////

  Future<void> refresh() async {
    page = 1;
    hasMore = true;
    await getAllArticles(page: 1);
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;

    final newArticle = await getAllArticles(page: page + 1);

    if (isSearching) {
      hasMore = false;
    }

    if (newArticle.isEmpty) {
      hasMore = false;
    } else {
      page++;
    }

    isLoadingMore = false;
    notifyListeners();
  }

  ////// ================= USER ACTIONS ================= //////

  // tap on sources
  void onTapChaneTapBar(int index) async {
    _selectedTapIndex = index;
    page = 1;
    hasMore = true;
    notifyListeners();
    await getAllArticles(page: 1);
  }

  // change country
  void onTapChaneDrawerCountry(String value) async {
    _selectCountry = value;
    notifyListeners();
  }

  // change theme
  void onTapChaneDrawerTheme(ThemeMode value) async {
    _selectTheme = value;
    notifyListeners();
  }

  // category tap
  void onCategoryTap(CategoryData categoryModel) {
    _selectedCategory = categoryModel;
    notifyListeners();
  }

  // back to home
  void goToHome(BuildContext context) {
    _selectedCategory = null;
    Navigator.pop(context);
    notifyListeners();
  }
}