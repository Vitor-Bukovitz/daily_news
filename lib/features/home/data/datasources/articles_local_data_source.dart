import 'dart:convert';

import 'package:daily_news/core/error/exceptions.dart';
import 'package:daily_news/features/home/data/models/article_model.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:hive/hive.dart';

abstract class ArticlesLocalDataSource {
  Future<List<ArticleEntity>> getCachedArticles(ArticlesType articlesType);
  Future<DateTime> getLastArticlesDateTime(ArticlesType articlesType);
  Future<void> cacheArticles(
    List<ArticleModel> articles,
    ArticlesType articlesType,
  );
}

const cachedArticlesKey = 'cachedArticlesKey';
const lastArticlesDateTimeKey = 'lastArticlesDateTimeKey';

class ArticlesLocalDataSourceImpl implements ArticlesLocalDataSource {
  final Box box;

  ArticlesLocalDataSourceImpl({required this.box});

  @override
  Future<void> cacheArticles(
    List<ArticleModel> articles,
    ArticlesType articlesType,
  ) async {
    await box.put(
      '$cachedArticlesKey${articlesType.name}',
      json.encode(articles.map((e) => e.toMap()).toList()),
    );
    await box.put(
      '$lastArticlesDateTimeKey${articlesType.name}',
      CustomizableDateTime.current,
    );
  }

  @override
  Future<List<ArticleEntity>> getCachedArticles(
    ArticlesType articlesType,
  ) async {
    final articlesJsonList = box.get(cachedArticlesKey);
    if (articlesJsonList == null || articlesJsonList.runtimeType != String) {
      throw CacheException();
    }
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
  Future<DateTime> getLastArticlesDateTime(ArticlesType articlesType) async {
    final dateTime = box.get('$lastArticlesDateTimeKey${articlesType.name}');
    if (dateTime.runtimeType != DateTime) throw CacheException();
    return dateTime;
  }
}

extension CustomizableDateTime on DateTime {
  static DateTime? _customTime;
  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  static set current(DateTime current) {
    _customTime = current;
  }
}
