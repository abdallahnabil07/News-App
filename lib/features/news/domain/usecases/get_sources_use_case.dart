import 'package:injectable/injectable.dart';
import 'package:news/features/news/data/data_sources/models/source_data_model.dart';
import 'package:news/features/news/domain/repository/source_repository.dart';

/// Use case responsible for fetching news sources.
///
/// Acts as an abstraction layer between:
/// - Presentation layer (Cubit)
/// - Domain/Data layer (Repository)
///
/// It ensures the UI does not depend directly on repository implementation.
@injectable
class GetSourcesUseCase {
  /// Repository responsible for retrieving sources data
  final SourceRepository repository;

  GetSourcesUseCase(this.repository);

  /// Fetches news sources for a specific category
  ///
  /// [categoryId] → ID of the selected category
  /// [country] → optional filter to get localized sources
  Future<List<SourceData>> call({
    required String categoryId,
    String? country,
  }) {
    return repository.getSources(
      categoryID: categoryId,
      country: country,
    );
  }
}