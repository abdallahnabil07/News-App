import 'package:hive/hive.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';

/// Local storage service for managing bookmarked articles.
///
/// Uses Hive as a lightweight local database to:
/// - Save articles
/// - Remove articles
/// - Check bookmark status
/// - Retrieve all saved bookmarks
class BookmarkService {
  /// Hive box used to store bookmarked articles
  static final Box _box = Hive.box('bookmarks');

  /// Saves an article to local storage using its URL as a unique key
  static void save(ArticlesDataModel article) {
    _box.put(article.url, {
      'title': article.title,
      'description': article.description,
      'url': article.url,
      'urlToImage': article.urlToImage,
      'publishedAt': article.publishedAt,
      'sourceName': article.sourceName,
    });
  }

  /// Removes a bookmarked article using its URL
  static void remove(String url) {
    _box.delete(url);
  }

  /// Checks whether an article is already bookmarked
  static bool isBookmarked(String url) {
    return _box.containsKey(url);
  }

  /// Retrieves all bookmarked articles from local storage
  ///
  /// Converts stored Map data back into [ArticlesDataModel]
  static List<ArticlesDataModel> getAll() {
    return _box.values.map((e) {
      final map = Map<String, dynamic>.from(e);

      return ArticlesDataModel(
        title: map['title'],
        description: map['description'],
        url: map['url'],
        urlToImage: map['urlToImage'],
        publishedAt: map['publishedAt'],
        sourceName: map['sourceName'],

        /// Fields not stored in Hive (fallback defaults)
        sourceId: '',
        content: '',
        author: '',
      );
    }).toList();
  }
}
