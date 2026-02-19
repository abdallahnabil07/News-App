import 'package:flutter/cupertino.dart';
import 'package:news/model/api/articles_data_model.dart';
import 'package:news/model/api/source_data_model.dart';
import 'package:news/network%20handler/network_handler.dart';

import '../../model/category_data.dart';

class HomeViewModel extends ChangeNotifier {
  int _selectedTapIndex = 0;
  String _selectCountry = "Egypt";
  String _selectTheme = "Dark";
  bool isLoading = false;
  String? errorMessage;
  CategoryData? _selectedCategory;

  int get currentIndex => _selectedTapIndex;

  String get selectCountry => _selectCountry;

  String get selectTheme => _selectTheme;

  CategoryData? get selectedCategory => _selectedCategory;
  List<SourceData> _sourceData = [];

  List<SourceData> get sourceData => _sourceData;

  List<ArticlesDataModel> _articles = [];

  List<ArticlesDataModel> get articles => _articles;

  Future<void> getAllSources(String categoryId) async {
    try {
      isLoading = true;
      errorMessage = null;
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

  Future<void> getAllArticles() async {
    if (sourceData.isEmpty) return;
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      _articles = await NetworkHandler.getNews(
        _sourceData[_selectedTapIndex].id,
      );
    } catch (error) {
      errorMessage = ("Something went wrong");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void onTapChaneTapBar(int index) async {
    _selectedTapIndex = index;
    notifyListeners();
    await getAllArticles();
  }

  void onTapChaneDrawerCountry(String value) async {
    _selectCountry = value;
    notifyListeners();
  }

  void onTapChaneDrawerTheme(String value) async {
    _selectTheme = value;
    notifyListeners();
  }

  void onCategoryTap(CategoryData categoryModel) {
    _selectedCategory = categoryModel;
    notifyListeners();
  }

  void goToHome(BuildContext context) {
    _selectedCategory = null;
    Navigator.pop(context);
    notifyListeners();
  }
}
