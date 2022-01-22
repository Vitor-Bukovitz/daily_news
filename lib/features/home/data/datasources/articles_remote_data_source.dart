import 'dart:convert';

import 'package:daily_news/core/error/exceptions.dart';
import 'package:daily_news/core/providers/config_providers.dart';
import 'package:daily_news/features/home/data/models/article_model.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:http/http.dart' as http;

abstract class ArticlesRemoteDataSource {
  Future<List<ArticleModel>> getArticles(ArticlesType articlesType);
}

class ArticlesRemoteDataSourceImpl implements ArticlesRemoteDataSource {
  final http.Client client;
  final EnvironmentConfig config;

  ArticlesRemoteDataSourceImpl({
    required this.client,
    required this.config,
  });

  @override
  Future<List<ArticleModel>> getArticles(ArticlesType articlesType) async {
    final params = {
      'category': articlesType.name,
      'apiKey': config.newsApiKey,
    };
    try {
      final uri = Uri.https(config.baseApiUrl, '/top-headlines', params);
      final response = await client.get(uri);
      if (response.statusCode != 200) throw ServerException();
      final articlesJson = json.decode(response.body);
      if (articlesJson is! Map<String, dynamic>) throw ServerException();
      final articlesListJson = articlesJson['articles'];
      if (articlesListJson is! List<dynamic>) throw ServerException();
      final articles =
          articlesListJson.map((e) => ArticleModel.fromMap(e)).toList();
      return articles;
    } on http.ClientException {
      throw ServerException();
    } on FormatException {
      throw ServerException();
    }
  }
}
