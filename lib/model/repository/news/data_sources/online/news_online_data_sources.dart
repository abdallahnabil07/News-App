import 'package:news/model/api/articles_data_model.dart';

abstract class NewsOnlineDataSources {
  Future<List<ArticlesDataModel>> getAllNews(String sourceID, {int page = 1});
}
