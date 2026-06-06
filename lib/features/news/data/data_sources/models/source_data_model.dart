/// Response model for news sources API.
///
/// Wraps API response metadata and list of sources.
class SourceDataModel {
  /// API response status (e.g. "ok", "error")
  final String status;

  /// List of available news sources
  final List<SourceData> sources;

  SourceDataModel({
    required this.status,
    required this.sources,
  });

  /// Creates an instance from JSON response
  factory SourceDataModel.fromJson(Map<String, dynamic> json) {
    return SourceDataModel(
      status: json["status"],
      sources: List.from(json["sources"]).map((element) {
        return SourceData.fromJson(element);
      }).toList(),
    );
  }
}

/// Model representing a single news source.
///
/// Each source contains metadata used for filtering and display.
class SourceData {
  /// Unique identifier of the source
  final String id;

  /// Display name of the news source
  final String name;

  /// Description of the news source
  final String description;

  /// Official website URL of the source
  final String url;

  /// Category of the source (e.g. sports, business)
  final String category;

  /// Language of the news source
  final String language;

  /// Country where the source is based
  final String country;

  SourceData({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  /// Creates an instance from JSON object
  factory SourceData.fromJson(Map<String, dynamic> json) {
    return SourceData(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      url: json["url"],
      category: json["category"],
      language: json["language"],
      country: json["country"],
    );
  }
}