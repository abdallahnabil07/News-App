import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:news/features/news/domain/repository/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  Future<List<ArticlesDataModel>> call(String sourceId, {int page = 1}) {
    return repository.getAllNews(sourceId, page: page);
  }
}
