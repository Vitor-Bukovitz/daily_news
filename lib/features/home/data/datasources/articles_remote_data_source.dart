import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';

abstract class ArticlesRemoteDataSource {
  Future<List<ArticleEntity>> getArticles(ArticlesType articlesType);
}
