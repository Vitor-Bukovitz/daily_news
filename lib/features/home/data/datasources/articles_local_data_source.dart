import 'dart:convert';

import 'package:daily_news/core/error/exceptions.dart';
import 'package:daily_news/features/home/data/models/article_model.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:hive/hive.dart';

abstract class ArticlesLocalDataSource {
  Future<List<ArticleEntity>> getCachedArticles(ArticlesType articlesType);
  Future<DateTime> getLastArticlesDateTime(ArticlesType articlesType);
  Future<void> cacheArticles(List<ArticleEntity> articles);
}

const cachedArticlesKey = 'cachedArticlesKey';

class ArticlesLocalDataSourceImpl implements ArticlesLocalDataSource {
  final Box box;

  ArticlesLocalDataSourceImpl({required this.box});

  @override
  Future<void> cacheArticles(List<ArticleEntity> articles) async {
    await box.put(cachedArticlesKey,
        json.encode(articles.map((e) => (e as ArticleModel).toMap()).toList()));
  }

  @override
  Future<List<ArticleEntity>> getCachedArticles(
    ArticlesType articlesType,
  ) async {
    final articlesJsonList = box.get(cachedArticlesKey);
    if (articlesJsonList == null) throw CacheException();
    if (articlesJsonList.runtimeType != String) throw CacheException();
    final articlesRawList = json.decode(articlesJsonList);
    if (articlesRawList.runtimeType != List) throw CacheException();
    try {
      final articles = (articlesRawList as List)
          .map(
            (e) => ArticleModel.fromMap(e),
          )
          .toList();
      return articles;
    } on FormatException {
      throw CacheException();
    }
  }

  @override
  Future<DateTime> getLastArticlesDateTime(ArticlesType articlesType) {
    // TODO: implement getLastArticlesDateTime
    throw UnimplementedError();
  }
}