import 'package:news/model/api/source_data_model.dart';

abstract class SourceOnlineDataSource {
  Future<List<SourceData>> getSources(String categoryId);
}
