import 'package:news/model/api/source_data_model.dart';

abstract class SourceRepository {
  Future<List<SourceData>> getSources(String categoryID);
}
