import 'package:daily_news/features/home/data/models/article_model.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';

abstract class ArticlesRemoteDataSource {
  Future<List<ArticleModel>> getArticles(ArticlesType articlesType);
}
