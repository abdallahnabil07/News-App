import 'package:injectable/injectable.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:news/features/news/domain/repository/news_repository.dart';

/// Use case responsible for fetching news articles.
///
/// Acts as a bridge between presentation layer (Cubit)
/// and domain/data layer (Repository).
///
/// It abstracts the data source so the Cubit does not depend
/// directly on repository implementation.
@injectable
class GetNewsUseCase {
  /// Repository responsible for fetching news data
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  /// Fetches news articles for a given source
  ///
  /// [sourceId] → ID of the news source
  /// [page] → pagination index (default = 1)
  Future<List<ArticlesDataModel>> call(String sourceId, {int page = 1}) {
    return repository.getAllNews(sourceId, page: page);
  }
}
