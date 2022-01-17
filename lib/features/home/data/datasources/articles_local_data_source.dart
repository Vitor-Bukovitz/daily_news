import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';

abstract class ArticlesLocalDataSource {
  Future<List<ArticleEntity>> getCachedArticles(ArticlesType articlesType);
  Future<DateTime> getLastArticlesDateTime(ArticlesType articlesType);
  Future<void> cacheArticles(List<ArticleEntity> articles);
}
