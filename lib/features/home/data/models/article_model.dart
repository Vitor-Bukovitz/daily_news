import 'package:daily_news/features/home/domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel({
    required String title,
    required String description,
    required String imageUrl,
    required DateTime publishedAt,
    required String content,
  }) : super(
          title: title,
          description: description,
          imageUrl: imageUrl,
          publishedAt: publishedAt,
          content: content,
        );
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt.millisecondsSinceEpoch,
      'content': content,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    if (map['title'] is String &&
        map['description'] is String &&
        map['urlToImage'] is String &&
        map['content'] is String) {
      return ArticleModel(
        title: map['title'],
        description: map['description'],
        imageUrl: map['urlToImage'],
        publishedAt: DateTime.parse(map['publishedAt']),
        content: map['content'],
      );
    } else {
      throw const FormatException();
    }
  }
}