import 'package:news/features/news/data/data_sources/models/source_data_model.dart';

abstract class SourceOnlineDataSource {
  Future<List<SourceData>> getSources(String categoryId);
}
