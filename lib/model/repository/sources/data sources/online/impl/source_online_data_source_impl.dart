import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news/model/api/source_data_model.dart';
import 'package:news/model/repository/sources/data%20sources/online/source_online_data_source.dart';
import 'package:news/network%20handler/api_constants.dart';
import 'package:news/network%20handler/end_points.dart';

@Injectable(as: SourceOnlineDataSource)
class SourceOnlineDataSourceImpl implements SourceOnlineDataSource {
  @override
  Future<List<SourceData>> getSources(String categoryId) async {
    try {
      Map<String, dynamic> queryParameters = {
        "apiKey": ApiConstants.apiKey,
        "category": categoryId,
      };
      final response = await http.get(
        Uri.http(ApiConstants.domain, EndPoints.allSources, queryParameters),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        SourceDataModel sourceDataModel = SourceDataModel.fromJson(data);
        return sourceDataModel.sources;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
