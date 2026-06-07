import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

import 'package:news/core/network/network%20handler/api_constants.dart';
import 'package:news/core/network/network%20handler/end_points.dart';
import 'package:news/core/network/network%20handler/network_exception.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:news/features/news/data/data_sources/online/news_online_data_sources.dart';

/// Remote data source implementation for fetching news articles.
///
/// Responsible for:
/// - Making HTTP requests to the news API
/// - Parsing JSON response into [ArticlesDataModel]
/// - Handling network errors and converting them into [NetworkException]
@Injectable(as: NewsOnlineDataSources)
class NewsOnlineDataSourceImpl implements NewsOnlineDataSources {
  /// Fetches news articles from remote API by source ID
  ///
  /// [sourceID] → news source identifier
  /// [page] → pagination index (default = 1)
  @override
  Future<List<ArticlesDataModel>> getAllNews(
      String sourceID, {
        int page = 1,
      }) async {
    try {
      // Build request URL with query parameters
      final uri = Uri.https(
        ApiConstants.domain,
        EndPoints.getNews,
        {
          "apiKey": ApiConstants.apiKey,
          "sources": sourceID,
          "page": page.toString(),
          "pageSize": "10",
        },
      );

      // Execute HTTP request with timeout
      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 5));

      // Success response handling
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return (data["articles"] as List)
            .map((json) => ArticlesDataModel.fromJson(json))
            .toList();
      }
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");
      // Handle non-success HTTP responses
      throw NetworkException.fromStatusCode(response.statusCode);
    }

    // No internet connection
    on SocketException {
      throw NetworkException.noInternet();
    }

    // Request timeout
    on TimeoutException {
      throw NetworkException.timeout();
    }

    // Unknown or unexpected errors
    catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException.unknown();
    }
  }
}