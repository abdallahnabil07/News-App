import 'package:injectable/injectable.dart';
import 'package:news/features/news/data/data_sources/models/source_data_model.dart';
import 'package:news/features/news/data/data_sources/online/source_online_data_source.dart';
import 'package:news/features/news/domain/repository/source_repository.dart';

/// Implementation of [SourceRepository].
///
/// Responsible for:
/// - Acting as a bridge between domain layer and online data source
/// - Delegating API calls to [SourceOnlineDataSource]
/// - Keeping domain layer independent from data layer implementation
@Injectable(as: SourceRepository)
class SourceRepositoryImpl implements SourceRepository {
  /// Remote data source responsible for fetching sources from API
  final SourceOnlineDataSource onlineDataSource;

  SourceRepositoryImpl(this.onlineDataSource);

  /// Fetches news sources from the online data source
  ///
  /// [categoryID] → category used to filter sources
  /// [country] → optional country filter for localized sources
  @override
  Future<List<SourceData>> getSources({
    required String categoryID,
    String? country,
  }) async {
    return onlineDataSource.getSources(
      country: country,
      categoryId: categoryID,
    );
  }
}