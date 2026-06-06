import 'package:injectable/injectable.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:news/features/news/data/data_sources/online/news_online_data_sources.dart';
import 'package:news/features/news/domain/repository/news_repository.dart';

/// Implementation of [NewsRepository].
///
/// Responsible for:
/// - Acting as a bridge between domain layer and data sources
/// - Delegating network calls to [NewsOnlineDataSources]
/// - Keeping repository abstraction clean for the domain layer
@Injectable(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  /// Remote data source responsible for API calls
  final NewsOnlineDataSources onlineDataSource;

  NewsRepositoryImpl(this.onlineDataSource);

  /// Fetches news articles from the online data source
  ///
  /// [sourceID] → ID of the news source
  /// [page] → pagination index (default = 1)
  @override
  Future<List<ArticlesDataModel>> getAllNews(
      String sourceID, {
        int page = 1,
      }) {
    return onlineDataSource.getAllNews(
      sourceID,
      page: page,
    );
  }
}