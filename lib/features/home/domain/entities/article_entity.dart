class ArticleEntity {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime publishedAt;
  final String content;

  const ArticleEntity({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });
}
