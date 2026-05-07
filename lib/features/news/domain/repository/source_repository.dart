import 'package:news/features/news/data/data_sources/models/source_data_model.dart';

abstract class SourceRepository {
  Future<List<SourceData>> getSources(String categoryID);
}
