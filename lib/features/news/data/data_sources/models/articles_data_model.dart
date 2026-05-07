class ArticlesDataModel {
  final String sourceId;
  final String sourceName;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String? author;

  ArticlesDataModel({
    required this.sourceId,
    required this.sourceName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.author,
  });

  factory ArticlesDataModel.fromJson(Map<String, dynamic> json) {
    return ArticlesDataModel(
      sourceId: json["source"]["id"],
      sourceName: json["source"]["name"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"],
      content: json["content"],
      author: json["author"],
    );
  }
}
