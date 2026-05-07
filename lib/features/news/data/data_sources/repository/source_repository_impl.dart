import 'package:injectable/injectable.dart';
import 'package:news/features/news/data/data_sources/models/source_data_model.dart';
import 'package:news/features/news/data/data_sources/online/source_online_data_source.dart';
import 'package:news/features/news/domain/repository/source_repository.dart';

@Injectable(as: SourceRepository)
class SourceRepositoryImpl implements SourceRepository {
  final SourceOnlineDataSource onlineDataSource;

  SourceRepositoryImpl(this.onlineDataSource);

  @override
  Future<List<SourceData>> getSources(String categoryID) async {
    return onlineDataSource.getSources(categoryID);
  }
}
