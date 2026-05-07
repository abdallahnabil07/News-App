import 'package:injectable/injectable.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:news/features/news/data/data_sources/online/news_online_data_sources.dart';
import 'package:news/features/news/domain/repository/news_repository.dart';

@Injectable(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsOnlineDataSources onlineDataSource;

  NewsRepositoryImpl(this.onlineDataSource);

  @override
  Future<List<ArticlesDataModel>> getAllNews(String sourceID, {int page = 1}) {
    return onlineDataSource.getAllNews(sourceID, page: page);
  }
}
