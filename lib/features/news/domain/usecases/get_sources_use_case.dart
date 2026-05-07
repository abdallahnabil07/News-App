import 'package:injectable/injectable.dart';
import 'package:news/features/news/data/data_sources/models/source_data_model.dart';
import 'package:news/features/news/domain/repository/source_repository.dart';

@injectable
class GetSourcesUseCase {
  final SourceRepository repository;

  GetSourcesUseCase(this.repository);

  Future<List<SourceData>> call(String categoryId) {
    return repository.getSources(categoryId);
  }
}
