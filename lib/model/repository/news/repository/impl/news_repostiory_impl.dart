import 'package:news/model/api/articles_data_model.dart';
import 'package:injectable/injectable.dart';
import 'package:news/model/repository/news/data_sources/online/news_online_data_sources.dart';
import 'package:news/model/repository/news/repository/news_repository.dart';

@Injectable(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsOnlineDataSources onlineDataSource;

  NewsRepositoryImpl(this.onlineDataSource);

  @override
  Future<List<ArticlesDataModel>> getAllNews(String sourceID, {int page = 1}) {
    return onlineDataSource.getAllNews(sourceID, page: page);
  }
}
