import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/model/api/articles_data_model.dart';
import 'package:news/model/api/source_data_model.dart';
import 'package:news/network%20handler/api_constants.dart';
import 'package:news/network%20handler/end_points.dart';

class NetworkHandler {
  static Future<List<SourceData>> getAllSource(String categoryId) async {
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
      throw Exception("Something went wrong");
    }
  }

  static Future<List<ArticlesDataModel>> getNews(String articlesId) async {
    List<ArticlesDataModel> articlesList = [];
    try {
      Map<String, dynamic> queryParameters = {
        "apiKey": ApiConstants.apiKey,
        "sources": articlesId,
      };
      var response = await http.get(
        Uri.http(ApiConstants.domain, EndPoints.getNews, queryParameters),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var element in data["articles"]) {
          ArticlesDataModel articlesDataModel = ArticlesDataModel.fromJson(
            element,
          );
          articlesList.add(articlesDataModel);
        }
        return articlesList;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (error) {
      throw Exception("Something went wrong");
    }
  }
}
