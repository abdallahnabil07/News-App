import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import 'package:news/core/network/network%20handler/api_constants.dart';
import 'package:news/core/network/network%20handler/end_points.dart';
import 'package:news/core/network/network%20handler/network_exception.dart';
import 'package:news/features/news/data/data_sources/models/source_data_model.dart';
import 'package:news/features/news/data/data_sources/online/source_online_data_source.dart';

/// Remote data source implementation for fetching news sources.
///
/// Responsible for:
/// - Building API request with query parameters
/// - Fetching sources from remote server
/// - Parsing JSON response into [SourceData]
/// - Converting network errors into [NetworkException]
@Injectable(as: SourceOnlineDataSource)
class SourceOnlineDataSourceImpl implements SourceOnlineDataSource {
  /// Fetches news sources from API based on category and optional country
  ///
  /// [categoryId] → category filter for sources
  /// [country] → optional country filter for localized sources
  @override
  Future<List<SourceData>> getSources({
    required String categoryId,
    String? country,
  }) async {
    try {
      /// Build query parameters for API request
      final params = {
        "apiKey": ApiConstants.apiKey,
        "category": categoryId,
      };

      /// Add country filter only if provided
      if (country != null && country.isNotEmpty) {
        params["country"] = country;
      }

      /// Construct request URL
      final uri = Uri.http(
        ApiConstants.domain,
        EndPoints.allSources,
        params,
      );

      /// Execute HTTP request with timeout protection
      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 5));

      /// Handle successful response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return SourceDataModel
            .fromJson(data)
            .sources;
      }

      /// Handle non-success HTTP responses
      throw NetworkException.fromStatusCode(response.statusCode);
    }

    /// No internet connection
    on SocketException {
      throw NetworkException.noInternet();
    }

    /// Request timeout
    on TimeoutException {
      throw NetworkException.timeout();
    }

    /// Unknown/unexpected errors
    catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException.unknown();
    }
  }
}