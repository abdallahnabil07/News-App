import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';

abstract class NewsRepository {
  Future<List<ArticlesDataModel>> getAllNews(String sourceID, {int page = 1});
}
