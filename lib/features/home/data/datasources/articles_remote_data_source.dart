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
  Future<List<ArticleModel>> getArticles(ArticlesType articlesType) {
    // TODO: implement getArticles
    throw UnimplementedError();
  }
}
