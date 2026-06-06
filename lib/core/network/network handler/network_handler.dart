import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:news/core/network/network%20handler/api_constants.dart';
import 'package:news/core/network/network%20handler/end_points.dart';
import 'package:news/core/network/network%20handler/network_exception.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:news/features/news/data/data_sources/models/source_data_model.dart';

/// Central network handler for all API requests.
///
/// Responsible for:
/// - Executing HTTP requests
/// - Handling errors and converting them to [NetworkException]
/// - Parsing JSON responses
/// - Providing reusable API methods for news & sources
class NetworkHandler {
  /// Base GET request handler with error handling and timeout
  static Future<dynamic> _get(Uri uri) async {
    try {
      final response =
      await http.get(uri).timeout(const Duration(seconds: 10));

      /// Successful response
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      /// Convert HTTP errors into domain exceptions
      throw NetworkException.fromStatusCode(response.statusCode);
    }

    /// No internet connection (Socket-level failure)
    on SocketException {
      throw NetworkException.noInternet();
    }

    /// HTTP protocol errors
    on HttpException {
      throw NetworkException.noInternet();
    }

    /// Invalid JSON or format issues
    on FormatException {
      throw NetworkException.unknown();
    }

    /// Request timeout
    on TimeoutException {
      throw NetworkException.timeout();
    }

    /// Fallback for any unknown error
    catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException.unknown();
    }
  }

  /// Fetches all sources for a specific category
  static Future<List<SourceData>> getAllSource(String categoryId) async {
    final uri = Uri.http(
      ApiConstants.domain,
      EndPoints.allSources,
      {
        "apiKey": ApiConstants.apiKey,
        "category": categoryId,
      },
    );

    final data = await _get(uri);
    return SourceDataModel
        .fromJson(data)
        .sources;
  }

  /// Fetches news articles for a specific source
  static Future<List<ArticlesDataModel>> getNews(String articlesId, {
    int page = 1,
  }) async {
    final uri = Uri.http(
      ApiConstants.domain,
      EndPoints.getNews,
      {
        "apiKey": ApiConstants.apiKey,
        "sources": articlesId,
        "page": page.toString(),
        "pageSize": "10",
      },
    );

    final data = await _get(uri);

    return (data["articles"] as List)
        .map((e) => ArticlesDataModel.fromJson(e))
        .toList();
  }

  /// Fetches news filtered by country
  static Future<List<ArticlesDataModel>> getNewsByCountry(String? country, {
    int page = 1,
  }) async {
    final params = {
      "apiKey": ApiConstants.apiKey,
      "page": page.toString(),
      "pageSize": "10",
    };

    /// Apply country filter only if valid
    if (country != null &&
        country.isNotEmpty &&
        country != "All Country") {
      params["country"] = country;
    }

    final uri = Uri.http(ApiConstants.domain, EndPoints.getNews, params);
    final data = await _get(uri);

    return (data["articles"] as List)
        .map((e) => ArticlesDataModel.fromJson(e))
        .toList();
  }

  /// Fetches news filtered by category and country
  static Future<List<ArticlesDataModel>> getNewsByCategoryAndCountry({
    required String categoryId,
    String? country,
    int page = 1,
  }) async {
    final params = {
      "apiKey": ApiConstants.apiKey,
      "category": categoryId,
      "page": page.toString(),
      "pageSize": "10",
    };

    /// Apply country filter only if valid
    if (country != null &&
        country.isNotEmpty &&
        country != "All Country") {
      params["country"] = country;
    }

    final uri = Uri.http(ApiConstants.domain, EndPoints.getNews, params);
    final data = await _get(uri);

    return (data["articles"] as List)
        .map((e) => ArticlesDataModel.fromJson(e))
        .toList();
  }
}