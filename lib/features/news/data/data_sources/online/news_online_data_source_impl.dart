import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news/core/network/network%20handler/api_constants.dart';
import 'package:news/core/network/network%20handler/end_points.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:news/features/news/data/data_sources/online/news_online_data_sources.dart';

@Injectable(as: NewsOnlineDataSources)
class NewsOnlineDataSourceImpl implements NewsOnlineDataSources {
  @override
  Future<List<ArticlesDataModel>> getAllNews(
    String sourceID, {
    int page = 1,
  }) async {
    List<ArticlesDataModel> articlesList = [];
    try {
      Map<String, dynamic> queryParameters = {
        "apiKey": ApiConstants.apiKey,
        "sources": sourceID,
        "page": page.toString(),
        "pageSize": "10",
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
